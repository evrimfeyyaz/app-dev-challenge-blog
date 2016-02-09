require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppDevChallenge
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.watchable_dirs['lib'] = [:rb]

    # Load the environment before config.x if the file exists.
    environment_variables = File.join(Rails.root, 'config', 'environment_variables.rb')
    load(environment_variables) if File.exists?(environment_variables)

    # Load the application preferences.
    config.x.preferences = Rails.application.config_for(:preferences)

    # Load the reCAPTCHA key.
    config.x.recaptcha = Rails.application.config_for(:recaptcha)

    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: "<appdevchallenge.com>",
      user_name: Rails.configuration.x.preferences["contact_email_username"],
      password: Rails.configuration.x.preferences["contact_email_password"],
      authentication: :plain,
      enable_starttls_auto: true
    }
    config.action_mailer.default_url_options = {
      host: "appdevchallenge.com"
    }
    config.action_mailer.raise_delivery_errors = true
  end
end
