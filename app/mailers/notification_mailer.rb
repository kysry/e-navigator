class NotificationMailer < ApplicationMailer
  def send_approval_date(user, current_user)
    @user = user
    @current_user = current_user
    @interview = @user.interviews.approval.first
    mail(
      to: @user.email,
      cc: @current_user.email,
      subject: "面接日時が承認されました。"
    )
  end

  def send_check_date(user, current_user)
    @user = user
    @current_user = current_user
    mail(
      to: @user.email,
      subject: "希望面接日時が申請されました。"
    )
  end
end
