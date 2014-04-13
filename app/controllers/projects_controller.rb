class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_user, :delete_user]
  before_action :check_owner, only: [:edit, :update, :destroy, :add_user, :delete_user]

  def index
    @own_projects = current_user.own_projects
    @projects = current_user.anothers_projects
  end

  def show
    @tasks = @project.tasks
  end

  def new
    @project = current_user.projects.new
  end

  def edit
  end

  def create
    @project = current_user.projects.new(project_params)
    @project.owner = current_user
    if @project.save
      @project.users << current_user
      redirect_to project_tasks_path(project_id: id), notice: 'Проект успешно создан.'
    else
      render action: 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Проект успешно обновлен.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Проект успешно удален.'
  end

  def add_user
    @project = current_user.projects.find(params[:project_id])
    @user = User.find_by email: params[:email]
    if @user
      if @project.users.find_by id: @user.id
        redirect_to @project, alert: 'Пользователь уже в проекте.'
      else
        @project.users << @user
        redirect_to @project, notice: 'Пользователь добавлен.'
      end
    else
      redirect_to @project, alert: 'Пользователь с таким email не найден'
    end
  end

  def delete_user
    @project = current_user.projects.find(params[:project_id])
    @user = User.find(params[:id])
    if @user
      if @project.users.find_by id: @user.id
        @project.users.delete(@user)
        redirect_to @project, notice: 'Пользователь удален'
      else
        redirect_to @project
      end
    else
      redirect_to @project, alert: 'Пользователь не существует'
    end
  end

  def tasks
    project = current_user.projects.find(params[:project_id])
    render partial:'projects/tasks/list', locals: {project: project}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      if params[:project_id]
        @project = current_user.projects.find(params[:project_id])
      else
        @project = current_user.projects.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title)
    end

    def check_owner
      unless @project.is_owner?(current_user)
        redirect_to projects_path, error: 'Недостаточно прав!'
      end
    end
end
