# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  enable_starttls_auto: true,
  address: ENV['SMTP_ADRESS'],
  port: ENV['SMTP_PORT'],
  authentication: :plain,
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD']
}
ActionMailer::Base.default_url_options[:host] = 'localhost:3000'
