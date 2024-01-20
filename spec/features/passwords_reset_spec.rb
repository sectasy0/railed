# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Password Resets' do
  let(:account) { accounts(:first) }

  describe 'password forgot form' do
    it 'should send reset instructions' do
      visit accounts_passwords_reset_password_forgot_path
      fill_in :account_email, with: account.email

      expect do
        submit_form
      end.to change { ActionMailer::Base.deliveries.size }.by(1)

      expect(page).to have_http_status(:success)
      content = 'You will receive an email with instructions on how to reset your password in a few minute'
      expect(page).to have_content(content)
    end

    it 'should redirect if already logged in' do
      sign_in_as account
      visit accounts_passwords_reset_password_forgot_path
      expect(page).to have_current_path(root_path)
    end

    it 'should not reset password if account is using oauth' do
      account.update(provider: 'discord', uid: 'f67b4d3d-c1de-4927-817b-10119be642e1')
      visit accounts_passwords_reset_password_forgot_path
      fill_in :account_email, with: account.email

      submit_form

      expect(page).to have_http_status(:success)
      expect(page).to have_content(I18n.t('controllers.passwords_reset.account_using_oauth'))
    end
  end

  describe 'password change form' do
    it 'should change password' do
      raw, hashed = Devise.token_generator.generate(Account, :reset_password_token)
      account.update(reset_password_token: hashed)
      account.update(reset_password_sent_at: Time.now.utc)
      visit accounts_passwords_reset_edit_path(reset_password_token: raw)

      fill_in :account_password, with: 'new_password1234'
      fill_in :account_password_confirmation, with: 'new_password1234'
      submit_form

      expect(page).to have_content('Your password has been changed successfully. You are now signed in')
    end

    it 'should not change password when incorrect' do
      raw, hashed = Devise.token_generator.generate(Account, :reset_password_token)
      account.update(reset_password_token: hashed)
      account.update(reset_password_sent_at: Time.now.utc)
      visit accounts_passwords_reset_edit_path(reset_password_token: raw)

      fill_in :account_password, with: ''
      fill_in :account_password_confirmation, with: 'new_password1234'
      submit_form

      expect(page).to have_content("Password can't be blank")
    end

    it 'should not change password when inconnect token' do
      visit accounts_passwords_reset_edit_path(reset_password_token: nil)
      expect(page).to have_content("You can't access this page without coming from a password reset email")
    end
  end
end
