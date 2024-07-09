class ProfilesController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :street, :city, :postal_code, :province)
  end
end
