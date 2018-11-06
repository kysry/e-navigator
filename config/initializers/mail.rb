ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  domain: 'gmail.com',
  port: 587,
  user_name: ENV["MAIL_ADRESS"],
  password: ENV["MAIL_PASSWORD"],
  authentication: 'plain',
  enable_starttls_auto: true
}
