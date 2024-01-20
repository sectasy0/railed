# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::SessionsController, type: :request do
  let(:account) { Account.create(name: 'John', email: 'connor@gmail.com', password: 'password') }

  describe 'POST /accounts/sign_in' do
    it 'signs in the account with valid credentials' do
      post new_account_session_path, params: { account: { email: account.email, password: 'password' } }
      expect(response).to redirect_to(dashboard_home_index_path)
      expect(response).to have_http_status(:see_other)
    end

    it 'does not sign in the account with invalid credentials' do
      post new_account_session_path, params: { account: { email: account.email, password: 'wrong_password' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE /accounts/sign_out' do
    it 'signs out the user' do
      sign_in(account)

      delete destroy_account_session_path
      expect(response).to redirect_to(new_account_session_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
