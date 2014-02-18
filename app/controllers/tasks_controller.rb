class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.eager_load(:project)
  end

  def show
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Задача успешно добавлена.'
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
      @task = current_user.tasks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :project_id)
    end

end
