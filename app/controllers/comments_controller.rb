class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(comment_params)
    @comment.user_id = current_user.id;
    if @comment.save
      redirect_to task_path(@task)
    else
      render 'static_pages/home'
    end
  end

 	private
   	  def comment_params
      	params.require(:comment).permit(:content)
   	  end
end