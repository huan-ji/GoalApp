class GoalsController < ApplicationController
  def index
    if current_user
      @goals = Goal.where("user_id = ? OR goal_type = ?", current_user.id, "public")
    else
      @goals = Goal.where(goal_type: "public")
    end
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params_for_edit)
      
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  private
  def goal_params
    params.require(:goal).permit(:description, :goal_type)
  end

  def goal_params_for_edit
    params.require(:goal).permit(:description, :goal_type, :completed)
  end
end
