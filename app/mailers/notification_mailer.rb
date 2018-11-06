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
end
