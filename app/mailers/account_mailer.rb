# frozen_string_literal: true

# AccountMailer class responsible for sending email notifications related to account actions.
class AccountMailer < ApplicationMailer
  # Sends a password reset email to the specified account.
  #
  # @param account [Account] The account for which the email is being sent.
  # @param token [String] The password reset token generated for the account.
  def password_reset(account, token)
    @account = account
    @token = token

    I18n.with_locale(@account.locale) do
      mail to: @account.email, subject: I18n.t('mailers.account_mailer.password_reset.subject')
    end
  end
end
