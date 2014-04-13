class Tasks::StatusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task
  before_action :is_project_member_or_own_task?

  def reopen
    @task.reopen
    redirect_to task_path(@task)
  end

  def start
    @task.start
    redirect_to task_path(@task)
  end

  def finish
    @task.finish
    redirect_to tasks_path
  end

  def suspend
    @task.suspend
    redirect_to task_path(@task)
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def is_project_member_or_own_task?
    unless @task.is_owner?(current_user) or (@task.project and @task.project.is_member?(current_user))
      redirect_to tasks_path, alert: 'Нет доступа!'
    end
  end

end