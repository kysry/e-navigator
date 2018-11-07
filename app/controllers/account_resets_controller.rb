class AccountResetsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def edit
  end

  def update
    @user = User.find(params[:user_id])
    if @user.update_attributes(user_params)
      redirect_to users_path(current_user), flash: {success: "プロフィールが更新されました。"}
    else
      redirect_to edit_user_account_reset_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:user_id])
    return redirect_to(root_url) unless current_user?(@user)
  end

end
