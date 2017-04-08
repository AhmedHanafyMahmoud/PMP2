class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  default from: ENV['MAILGUN_SMTP_LOGIN']

  
  def signup_confirmation(user)
  	@user = user
  	mail to: user.email, subject: "sign up confirmation" do |format|
        # format.text
        # or
        format.html
    end
  end
end
