# frozen_string_literal: true

# This module provides CAPTCHA handling functionality for controllers.
module Recaptchable
  extend ActiveSupport::Concern

  # Class method that specifies which controller actions require CAPTCHA challenges.
  class_methods do
    # Specify one or more actions that require CAPTCHA challenges.
    #
    # @param actions [Hash<Symbol>] Action that requires CAPTCHA challenge.
    # @param render [Symbol] View to render if CAPTCHA challenge fails.
    def captcha_actions(action, render)
      (@actions ||= {})[action.to_s] = render
    end
  end

  included do
    class_eval do
      prepend_before_action(:check_captcha, if: proc {
        self.class.instance_variable_get(:@actions)&.key?(action_name)
      })
    end
  end

  # Instance method that checks the validity of a CAPTCHA challenge for a controller action.
  #
  # This method checks if the CAPTCHA challenge for the current controller's action is valid.
  # If the CAPTCHA is valid, it returns true. If not, it sets the instance variable
  # @show_checkbox_recaptcha to true, indicating the need for a checkbox CAPTCHA v2 challenge,
  # and sets a flash message to warn the user about the CAPTCHA requirement.
  #
  # @return [Boolean] True if CAPTCHA is valid, false otherwise.
  def check_captcha
    # Assume valid_captcha? method checks the validity of CAPTCHA for the specified action.
    return true if valid_captcha?("#{controller_name}/#{action_name}")

    # Trigger checkbox CAPTCHA challenge and display a warning flash message.
    @show_checkbox_recaptcha = true
    flash.now[:warning] = I18n.t('recaptcha.confirm')
    render(self.class.instance_variable_get(:@actions)[action_name], status: :unprocessable_entity) and return
  end

  private

  def valid_captcha?(action)
    secret_key = Rails.application.credentials[:recaptcha_secret_key_v2]
    success = verify_recaptcha(action:)
    checkbox_success = verify_recaptcha(secret_key:) unless success
    return true if success || checkbox_success

    false
  end
end
