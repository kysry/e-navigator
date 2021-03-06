class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to users_path(current_user), flash: {success: "ユーザー登録が完了しました。"}
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = user_params
    if @user.save(context: :update_without_password)
      redirect_to users_path(current_user), flash: {success: "プロフィールが更新されました。"}
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                  :name, :birthday, :gender, :school)
  end

  def correct_user
    @user = User.find(params[:id])
    return redirect_to(root_url) unless current_user?(@user)
  end

end
