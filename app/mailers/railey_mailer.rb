# frozen_string_literal: true

# RaileyMailer class responsible for sending email notifications related to application
class RaileyMailer < ApplicationMailer
  # Sends new contact form submission
  #
  # @param form_data [Hash] Data from contact form
  def contact(form_data)
    @form_data = form_data

    to = Rails.application.config_for(:config)[:app_mail]
    I18n.with_locale(:en) do
      mail to:, subject: I18n.t('mailers.railey_mailer.contact.subject')
    end
  end
end
