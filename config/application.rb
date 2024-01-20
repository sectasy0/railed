# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'devise'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Railed
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.exceptions_app = ->(env) { ErrorsController.action(:show).call(env) }

    config.assets.initialize_on_precompile = false

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = 'Central Time (US & Canada)'
    # config.eager_load_paths << Rails.root.join('extras')

    credentials.config.each do |key, value|
      if key.to_s == Rails.env
        value.each do |env_key, env_value|
          ENV[env_key.to_s.upcase] = env_value.to_s if ENV[env_key.to_s.upcase].blank?
          ENV[env_key.to_s.downcase] = env_value.to_s if ENV[env_key.to_s.downcase].blank?
        end
      elsif ['development', 'staging', 'test', 'production'].include?(key.to_s) == false
        ENV[key.to_s.upcase] = value.to_s if ENV[key.to_s.upcase].blank?
        ENV[key.to_s.downcase] = value.to_s if ENV[key.to_s.downcase].blank?
      end
    end

    config.i18n.available_locales = %i[pl en de]
    config.i18n.default_locale = :en

    config.generators do |g|
      g.skip_routes true
      g.helper false
      g.assets false
      g.test_framework :rspec, fixture: false
      g.helper_specs false
      g.controller_specs false
      g.system_tests false
      g.view_specs false
    end

    config.generators do |g|
      g.template_engine :slim
    end

    # GZip all responses
    config.middleware.use Rack::Deflater

    # Fix tailwind/administrate issue
    config.assets.css_compressor = nil
  end
end
