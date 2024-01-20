# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RegistrationsTest' do
  it 'should create new account' do
    visit new_account_registration_path

    fill_in :account_name, with: 'Test'
    fill_in :account_email, with: 'test@example.com'
    fill_in :account_password, with: 'testpassword_aaaaa'
    fill_in :account_password_confirmation, with: 'testpassword_aaaaa'
    submit_form

    assert_text 'Welcome! You have signed up successfully.'
  end

  it 'should not create new account but without name' do
    visit new_account_registration_path

    fill_in :account_email, with: 'test@example.com'
    fill_in :account_password, with: 'testpassword_aaaaa'
    fill_in :account_password_confirmation, with: 'testpassword_aaaaa'
    submit_form

    assert_text "Username can't be blank"
  end

  it 'should not create new account without email' do
    visit new_account_registration_path

    fill_in :account_name, with: 'Test'
    fill_in :account_password, with: 'testpassword_aaaaa'
    fill_in :account_password_confirmation, with: 'testpassword_aaaaa'
    submit_form

    assert_text "Email can't be blank"
  end

  it 'should not create new account without password' do
    visit new_account_registration_path

    fill_in :account_name, with: 'Test'
    fill_in :account_email, with: 'test@example.com'
    fill_in :account_password_confirmation, with: 'testpassword_aaaaa'
    submit_form

    assert_text "Password can't be blank"
  end

  it 'should not create new account without password confirmation' do
    visit new_account_registration_path

    fill_in :account_name, with: 'Test'
    fill_in :account_email, with: 'test@example.com'
    fill_in :account_password, with: 'testpassword_aaaaa'
    submit_form

    assert_text "Password confirmation doesn't match Password"
  end

  it 'should not create new account when another with email exists' do
    Account.create(email: 'test@example.com', name: 'Test', password: 'testpassword_aaaaa')

    visit new_account_registration_path

    fill_in :account_name, with: 'Test'
    fill_in :account_email, with: 'test@example.com'
    fill_in :account_password, with: 'testpassword_aaaaa'
    fill_in :account_password_confirmation, with: 'testpassword_aaaaa'
    submit_form

    assert_text 'Email has already been taken'
  end
end
