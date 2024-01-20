# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PasswordsTest' do
  let(:account) { accounts(:first) }
  before { sign_in_as(account) }

  it 'updating the password' do
    visit root_path
    click_on I18n.t('menu.dropdown.change_password'), match: :first

    fill_in :account_current_password, with: 'secret_password'
    fill_in :account_password, with: 'Secret6*4*2*'
    fill_in :account_password_confirmation, with: 'Secret6*4*2*'
    submit_form

    assert_text 'Your password has been changed'
  end

  it 'updating the password but incorrect current' do
    visit root_path
    click_on I18n.t('menu.dropdown.change_password'), match: :first

    fill_in :account_current_password, with: 'secret_password123'
    fill_in :account_password, with: 'Secret6*4*2*'
    fill_in :account_password_confirmation, with: 'Secret6*4*2*'
    submit_form

    assert_text 'The current password you entered is incorrect'
  end

  it 'updating the password but passwords dont match' do
    visit root_path
    click_on I18n.t('menu.dropdown.change_password'), match: :first

    fill_in :account_current_password, with: 'secret_password'
    fill_in :account_password, with: 'Secret6*4*2*'
    fill_in :account_password_confirmation, with: 'Secret6*4*2*66'
    submit_form

    assert_text "Password confirmation doesn't match Password"
  end

  it 'updating the password but password too short' do
    visit root_path
    click_on I18n.t('menu.dropdown.change_password'), match: :first

    fill_in :account_current_password, with: 'secret_password'
    fill_in :account_password, with: 'test'
    fill_in :account_password_confirmation, with: 'test'
    submit_form

    assert_text 'Password is too short (minimum is 8 characters)'
  end

  it 'should not find change password in menu if account uses oauth' do
    account.update(provider: 'discord', uid: 'f67b4d3d-c1de-4927-817b-10119be642e1')

    visit root_path

    expect do
      click_on I18n.t('menu.dropdown.change_password'), match: :first
    end
      .to raise_error(Capybara::ElementNotFound)
  end
end
