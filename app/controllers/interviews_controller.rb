class InterviewsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :destroy]

  def index
    @user = User.find(params[:user_id])
    @users = User.where.not(id: current_user.id)
    @interviews = @user.interviews.all
    @interview_approval = @user.interviews.find_by(interview_condition: 1)
  end

  def new
    @interview = current_user.interviews.build
  end

  def create
    @interview = current_user.interviews.create(interview_params)
    if @interview.save
      redirect_to user_interviews_path(current_user), flash: {success: "面接日時が追加されました。"}
    else
      render :new
    end
  end

  def edit
    @interview = Interview.find(params[:id])
  end

  def update
    @interview = Interview.find(params[:id])
    if @interview.update_attributes(interview_params)
      redirect_to request.referrer, flash: {success: "面接日時が更新されました。"}
    else
      render :edit
    end
  end

  def confirm
    user = User.find(params[:user_id])
    interview = Interview.find(params[:id])
    if interview.update_attributes(interview_params)
      denied_interview = user.interviews.where.not(id: interview.id)
      denied_interview.update_all ['interview_condition = ?', 2]
      NotificationMailer.send_approvaldate(user, current_user).deliver
      redirect_to user_interviews_path(user), flash: {success: "面接日時を承認し、メールを送信しました。"}
    else
      render :edit
    end
  end

  def check_date
    @user = User.find(params[:user_id])
    NotificationMailer.send_checkdate(@user, current_user).deliver
    redirect_to request.referrer, flash: {success: "メールの送信が完了しました。"}
  end

  def destroy
    @interview.destroy
    redirect_to request.referrer || root_url, flash: {success: "削除されました。"}
  end

  private

   def interview_params
     params.require(:interview).permit(:interview_date, :interview_condition)
   end

   def correct_user
     @interview = current_user.interviews.find_by(id: params[:id])
     redirect_to interviews_path if @interview.nil?
   end

end
