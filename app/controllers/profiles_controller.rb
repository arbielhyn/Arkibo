class ProfilesController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in
  def profile
    @user = current_user
    @orders = @user.orders.includes(order_items: :product)
  end

  def show
    @user = current_user
    @orders = @user.orders.includes(order_items: :product)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,
                                 :current_password)
  end
end
