class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :is_own_task?, only: [:edit, :update, :destroy]
  before_action :is_project_member?, only: [:show]

  def index
    @tasks = current_user.tasks.eager_load(:project)
  end

  def tasks_without_project
    tasks = current_user.tasks.where(project_id: nil)    
    render partial: 'tasks_without_project', locals: {tasks: tasks}
  end

  def show
  end

  def new
    @task = current_user.tasks.new(project_id: params[:project_id])
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      if @task.project
        redirect_to @task.project, notice: 'Задача успешно добавлена.'
      else
        redirect_to tasks_path, notice: 'Задача успешно добавлена.'
      end
    else
      render action: 'new'
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Задача успешно обновлена.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def is_own_task?
      redirect_to(tasks_path, alert: 'Нет доступа!') unless @task.is_owner?(current_user)
    end

    def is_project_member?
      if @task.project and not @task.project.users.include?(current_user)
        redirect_to tasks_path, alert: 'Нет доступа!'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :project_id, :state)
    end

end
