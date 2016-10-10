class GoalsController < ApplicationController
  before_action :redirect_if_not_logged_in!
  before_action :set_goal, only: [:destroy, :update, :edit, :show]
  before_action :redirect_unless_owner!, only: [:destroy, :update, :edit]

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to new_goal_url
    end
  end

  def show
    redirect_unless_owner! unless @goal.publicly_viewable
  end

  def destroy
    @goal.destroy
    flash[:errors] = ["Goal was deleted"]
    redirect_to user_url(current_user)
  end

  def update
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to edit_goal_url(@goal)
    end
  end

  private
  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:description, :publicly_viewable, :completed)
  end

  def redirect_unless_owner!
    redirect_to user_url(current_user) unless @goal.user == current_user
  end

end
