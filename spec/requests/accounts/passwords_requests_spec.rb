# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::PasswordsController, type: :request do
  let(:account) { accounts(:first) }

  before { sign_in(account) }

  describe 'GET #edit' do
    it 'renders the edit password page successfully' do
      get accounts_passwords_edit_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end

    it 'renders the edit password page successfully oauth2 account' do
      account.update(provider: 'discord', uid: 'f67b4d3d-c1de-4927-817b-10119be642e1')
      get accounts_passwords_edit_path
      expect(response).to have_http_status(:redirect)
      expect(flash[:alert]).to eq(I18n.t('controllers.passwords_reset.account_using_oauth'))
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          account: {
            current_password: 'old_password',
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
      end

      it 'updates the password successfully' do
        account.password = 'old_password'
        patch accounts_passwords_update_path, params: valid_params
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to be_present
      end

      it 'should not update if account uses oauth' do
        account.update(provider: 'discord', uid: 'f67b4d3d-c1de-4927-817b-10119be642e1')

        account.password = 'old_password'
        patch accounts_passwords_update_path, params: valid_params
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq(I18n.t('controllers.passwords_reset.account_using_oauth'))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          account: {
            current_password: 'wrong_password',
            password: 'new_password',
            password_confirmation: 'different_password'
          }
        }
      end

      it 'does not update the password' do
        patch accounts_passwords_update_path, params: invalid_params
        expect(response).to redirect_to(accounts_passwords_edit_path)
      end
    end
  end
end
