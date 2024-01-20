# frozen_string_literal: true

module RequestHelper
  # def sign_in(account)
  #   post(new_account_session_path, params: {
  #     account: { email: account.email, password: account.password }
  #   })
  #   account
  # end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
  config.before(:each, type: :request) { host! 'railed.test' }
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Warden::Test::Helpers, type: :request
end
