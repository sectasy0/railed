# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SessionsTest' do
  let(:account) { accounts(:first) }

  it 'signing in' do
    visit new_account_session_path
    fill_in :account_email, with: account.email
    fill_in :account_password, with: 'secret_password'
    submit_form

    assert_text 'Signed in successfully'
  end

  it 'signing in failed' do
    visit new_account_session_path
    fill_in :account_email, with: account.email
    fill_in :account_password, with: 'Secret1*3*5*'
    submit_form

    assert_text 'Invalid Email or password'
  end

  it 'signing out' do
    sign_in_as account

    click_on 'Log out', match: :first
    assert_text 'Signed out successfully'
  end
end
