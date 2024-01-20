# frozen_string_literal: true

module SystemTestHelper
  WebMock.disable_net_connect!(allow_localhost: true, allow: ['http://selenium:4444'])

  def sign_in_as(account)
    visit new_account_session_path
    fill_in :account_email, with: account.email
    fill_in :account_password, with: 'secret_password'
    submit_form

    assert find_all('div[id="flash_alert"]')[0].nil?
    assert_current_path dashboard_home_index_path
    account
  end

  def open_debug!
    page.driver.debug(binding)
  end

  def submit_form
    find('input[name="commit"]').click
  end
end

RSpec.configure do |config|
  config.include SystemTestHelper, type: :feature
end
