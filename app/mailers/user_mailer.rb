class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  default from: 'ahr.mahmoud@gmail.com'

  
  def signup_confirmation(user)
  	@user = user
  	mail to: user.email, subject: "sign up confirmation"
  end
end
