class NotificationMailer < ApplicationMailer
  def send_approvaldate(user, current_user)
    @user = user
    @current_user = current_user
    @interview = @user.interviews.find_by(interview_condition: 1)
    mail(
      to: @user.email,
      cc: @current_user.email,
      subject: "面接日時が承認されました。"
    )
  end

  def send_checkdate(user, current_user)
  @user = user
  @current_user = current_user
  mail(
    to: @user.email,
    subject: "希望面接日時が申請されました。"
  )
  end
end
