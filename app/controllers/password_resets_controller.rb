class PasswordResetsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def edit
  end

  def update
    @user = User.find(params[:user_id])
    if @user.update_attributes(user_params)
      redirect_to users_path(current_user), flash: {success: "パスワードが変更されました。"}
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:user_id])
    return redirect_to(root_url) unless current_user?(@user)
  end

end
