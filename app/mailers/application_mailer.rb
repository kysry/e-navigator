class ApplicationMailer < ActionMailer::Base
  default from: ENV["MAIL_ADRESS"] 
  layout 'mailer'
end
