class TaskListController < ApplicationController
  before_action :authenticate_user!
  layout false

  def all
    @tasks = current_user.all_tasks
    render partial: 'tasks_with_project', locals:{tasks: @tasks}
  end

  def without_project
    @tasks = current_user.tasks.without_project
  end

  def project
    @project = current_user.projects.find(params[:id])
    @tasks = @project.tasks
  end
end