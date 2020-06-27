class SubscriptionMailer < ApplicationMailer
  default from: ENV['SMTP_USERNAME']

# Greeting new subscribers
#
  def welcome_email
    @email = params[:email]
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end

# Upcoming Event Alert
#
  def upcoming_event_alert
    days = params.nil? ? 1 : params.fetch(:days, 1) #add default 'before days'
    date = (Date.today + days)
    @events = Event.find_by_date(date)
    unless @events.blank?
      Subscriber.all_active.each do |subscriber|
        mail(to: subscriber.email, subject: 'Оповещение о предстоящих событиях')
      end
    end
  end
end