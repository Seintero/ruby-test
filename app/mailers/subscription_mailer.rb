class SubscriptionMailer < ApplicationMailer
  default from: ENV['SMTP_USERNAME']

# Greeting new subscribers
#
  def welcome_email
    @email = params[:email]
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end
end