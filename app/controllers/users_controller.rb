class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create, :update]

  def show
    @user=User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(account_update_params)
      redirect_to :root, notice: "Profile was succesfully updated!"
    else
      render :root, notice: "#{@user.errors.full_messages}"
    end
  end

  private
    def set_user
      @user=current_user
    end

    def account_update_params
      params.require(:user).permit(:avatar, :phone_number, :adress, :name, :email, :password, :password_confirmation, :current_password)
    end
end
