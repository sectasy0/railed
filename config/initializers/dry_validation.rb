# frozen_string_literal: true

require 'dry-validation'
require 'i18n'

module Dry
  module Validation
    ##
    # Configure error translations for validation contracts
    #
    class Contract
      I18n.available_locales.each do |locale|
        path = Rails.root.join('config', 'locales', 'dry_validation', "errors.#{locale}.yml")
        config.messages.load_paths << path
      end

      config.messages.default_locale = I18n.default_locale

      def self.t(path, **args)
        text = messages.data["#{I18n.locale}#{path}"][:text]
        return nil unless text

        args.each do |k, v|
          text = text.gsub("%{#{k}}", v.to_s)
        end

        text
      rescue StandardError
        nil
      end
    end
  end
end
