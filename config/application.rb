# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    #  config.web_console.permissions = '172.22.0.1'
    # config.web_console.whitelisted_ips = '172.22.0.1'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = 'Moscow'
    config.active_record.default_timezone = 'Moscow'
    config.i18n.default_locale = :ru
    config.exceptions_app = routes
    config.autoload_paths << "#{Rails.root}/lib"
  end
end
