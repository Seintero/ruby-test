# frozen_string_literal: true

namespace :subscribers do
  desc 'Send an email to subscriber about future events'
  task notify: [:environment] do
    puts 'start send email to subscribers'
    begin
      SubscriptionMailer.with(days: 1).upcoming_event_alert.deliver_now
    rescue StandardError => e
      puts "task stopped #{e.message}"
    end
    puts 'end send email to subscribers'
  end
end
