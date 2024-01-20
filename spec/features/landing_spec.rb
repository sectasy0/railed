# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ContactTest' do
  let(:account) { accounts(:first) }

  it 'should send message as unathorized' do
    visit root_path
    click_on I18n.t('menu.contact'), match: :first

    fill_in :contact_email, with: 'valid@email.com'
    fill_in :contact_subject, with: 'Test'
    fill_in :contact_message, with: 'aaaaa'
    submit_form

    assert_text I18n.t('controllers.landing.contact.sent')
  end

  it 'should not send message as unathorized when invalid email' do
    visit root_path
    click_on I18n.t('menu.contact'), match: :first

    fill_in :contact_email, with: 'invalid_email'
    fill_in :contact_subject, with: 'Test'
    fill_in :contact_message, with: 'aaaaa'
    submit_form

    assert_text I18n.t('controllers.landing.contact.invalid_email')
  end

  it 'should send message as authorized' do
    visit root_path
    sign_in_as(account)
    click_on 'user-menu-button', match: :first
    click_on I18n.t('menu.dropdown.report_bug'), match: :first

    fill_in :contact_email, with: 'valid@email.com'
    fill_in :contact_subject, with: 'Test'
    fill_in :contact_message, with: 'aaaaa'
    submit_form

    assert_text I18n.t('controllers.landing.contact.sent')
  end

  it 'should send message as authorized' do
    visit root_path
    sign_in_as(account)
    click_on 'user-menu-button', match: :first
    click_on I18n.t('menu.dropdown.report_bug'), match: :first

    fill_in :contact_email, with: 'invalid_email'
    fill_in :contact_subject, with: 'Test'
    fill_in :contact_message, with: 'aaaaa'
    submit_form

    assert_text I18n.t('controllers.landing.contact.invalid_email')
  end
end
