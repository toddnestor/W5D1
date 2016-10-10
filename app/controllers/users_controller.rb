class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @goals = @user.goals
    else
      @goals = @user.goals.where(publicly_viewable: true)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
