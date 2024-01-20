# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::RegistrationsController, type: :request do
  describe 'GET /accounts/sign_up' do
    it 'renders the sign-up page successfully' do
      get new_account_registration_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /accounts' do
    context 'with valid parameters' do
      let(:valid_account_params) do
        {
          account: {
            name: 'test555',
            email: 'test@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'creates a new account' do
        expect do
          post account_registration_path, params: valid_account_params
        end.to change(Account, :count).by(1)

        expect(response).to redirect_to(dashboard_home_index_path)
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid parameters' do
      let(:account_params) do
        {
          account: {
            name: 'test',
            email: 'invalid_email',
            password: 'password',
            password_confirmation: 'different_password'
          }
        }
      end

      it 'does not create a new account without name' do
        expect do
          post account_registration_path, params: account_params.except(:name)
        end.not_to change(Account, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end

      it 'does not create a new account with invalid email' do
        expect do
          post account_registration_path, params: account_params
        end.not_to change(Account, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end

      it 'does not create a new account without password' do
        expect do
          post account_registration_path, params: account_params.except(:name)
        end.not_to change(Account, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end
end
