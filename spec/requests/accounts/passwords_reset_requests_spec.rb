# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::PasswordsResetController, type: :request do
  describe 'GET #new' do
    let(:account) { accounts(:first) }
    it 'returns a successful response' do
      get accounts_passwords_reset_password_forgot_path
      expect(response).to be_successful
    end

    it 'should redirect if already logged in' do
      sign_in(account)
      get accounts_passwords_reset_password_forgot_path
      expect(response).to be_redirect
    end
  end

  describe 'POST #create' do
    context 'with valid email' do
      let(:account) { accounts(:first) }

      it 'generates a reset token, sends email, and redirects' do
        expect(AccountMailer).to receive(:password_reset).and_call_original
        post accounts_passwords_reset_password_reset_path, params: { account: { email: account.email } }
        expect(response).to redirect_to(accounts_passwords_reset_password_forgot_path)
        expect(flash[:notice]).to be_present
      end

      it 'should redirect if already logged in' do
        sign_in(account)
        post accounts_passwords_reset_password_reset_path, params: { account: { email: account.email } }
        expect(response).to be_redirect
      end

      it 'should not reset if account using oauth' do
        account.update(provider: 'discord', uid: 'f67b4d3d-c1de-4927-817b-10119be642e1')
        sign_in(account)
        post accounts_passwords_reset_password_reset_path, params: { account: { email: account.email } }
        expect(account.reset_password_token).to be_nil
        expect(account.reset_password_sent_at).to be_nil
      end
    end

    context 'with empty email' do
      it 'redirects with an alert' do
        post accounts_passwords_reset_password_reset_path, params: { account: { email: '' } }
        expect(response).to redirect_to(accounts_passwords_reset_password_forgot_path)
        expect(flash[:alert]).to be_present
      end
    end

    context 'with non-existing email' do
      it 'redirects with an alert' do
        post accounts_passwords_reset_password_reset_path, params: { account: { email: 'nonexistent@example.com' } }
        expect(response).to redirect_to(accounts_passwords_reset_password_forgot_path)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'GET #edit' do
    let(:account) { accounts(:first_with_reset_token) }

    it 'returns a successful response' do
      get accounts_passwords_reset_edit_path(reset_password_token: account.reset_password_token)
      expect(response).to be_successful
    end

    it 'should show an error invalid token' do
      get accounts_passwords_reset_edit_path(reset_password_token: nil)
      expect(flash[:alert]).to be_present
    end
  end

  describe 'patch #update' do
    let(:account) { accounts(:first) }

    context 'with valid reset token and matching passwords' do
      it 'updates password and signs in' do
        raw, hashed = Devise.token_generator.generate(Account, :reset_password_token)
        account.update(reset_password_token: hashed)
        account.update(reset_password_sent_at: Time.now.utc)
        patch accounts_passwords_reset_update_path, params: {
          account: {
            password: 'new_password',
            password_confirmation: 'new_password',
            reset_password_token: raw
          }
        }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Your password has been changed successfully. You are now signed in')
      end
    end

    context 'with invalid reset token' do
      it 'renders edit with an error' do
        patch accounts_passwords_reset_update_path, params: {
          account: {
            password: 'new_password',
            password_confirmation: 'new_password',
            reset_password_token: 'invalid_token'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end
end
