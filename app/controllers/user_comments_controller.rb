class UserCommentsController < ApplicationController
  def new
  end

  def create
    @user_comment = current_user.authored_comments.new(user_params)
    unless @user_comment.save
      flash[:errors] = @user_comment.errors.full_messages
    end
    redirect_to users_url
  end

  def destroy
    @user_comment = UserComment.find(params[:id])
    @user_comment.destroy
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user_comment).permit(:body, :user_id)
  end
end
