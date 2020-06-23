class SubscriptionMailer < ApplicationMailer
  default from: ENV['SMTP_USERNAME']

# Greeting new subscribers
#
  def welcome_emailpublic
    @email = params[:email]
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end

# Upcoming Event Alert
#
  def upcoming_event_alert
    days = params[:days]
    date = (Time.now + days * 86400).strftime("%Y-%m-%d")
    @events = Event.find_by_date(date)
    unless @events.blank?
      Subscriber.all_active.each do |subscriber|
        mail(to: subscriber.email, subject: 'Оповещение о предстоящих событиях')
      end
    end
  end
end