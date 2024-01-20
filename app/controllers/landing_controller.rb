# frozen_string_literal: true

# Controller responsible for handling app landing
class LandingController < ApplicationController
  skip_before_action :authenticate_account!

  include Recaptchable
  captcha_actions :send_message, :contact

  def index; end

  def contact; end

  def send_message
    invalid_email and return unless contact_params[:email].match?(Devise.email_regexp)

    RaileyMailer.contact(contact_params).deliver_later
    redirect_to(root_path, notice: I18n.t('controllers.landing.contact.sent'))
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :subject, :message)
  end

  def invalid_email
    redirect_to(contact_path, alert: I18n.t('controllers.landing.contact.invalid_email'))
  end
end
