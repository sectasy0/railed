# frozen_string_literal: true

# This is the base mailer class for the application. It provides default configurations
# for sending emails, including the sender address and the layout for email templates.
# Other mailer classes in the application can inherit from this class to benefit from
# the default settings.
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
