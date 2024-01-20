# frozen_string_literal: true

module MailHelper
  def reset_emails!
    ActionMailer::Base.deliveries.clear
  end

  def last_email
    ActionMailer::Base.deliveries.last
  end

  def delivered_emails
    ActionMailer::Base.deliveries
  end
end

RSpec.configure do |config|
  config.include MailHelper
  config.before { reset_emails! }
end
