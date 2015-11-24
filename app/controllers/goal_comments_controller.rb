class GoalCommentsController < ApplicationController
  def new
  end

  def create
    @goal_comment = current_user.goal_comments.new(goal_params)
    unless @goal_comment.save
      flash[:errors] = @goal_comment.errors.full_messages
    end
    redirect_to goal_url(@goal_comment.goal)
  end

  def destroy
    @goal_comment = GoalComment.find(params[:id])
    # do we need to save the goal?
    @goal_comment.destroy
    redirect_to goal_url(@goal_comment.goal)
  end

  private
  def goal_params
    params.require(:goal_comment).permit(:body, :goal_id)
  end
end
