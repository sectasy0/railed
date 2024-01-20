# frozen_string_literal: true

require 'capybara/cuprite'
require 'capybara/rspec'

Capybara.javascript_driver = :cuprite

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 800],
    url: ENV.fetch('BROWSERLESS_URL', nil),
    headless: true,
    'no-sandbox': true,
    'disable-gpu': true,
    inspector: ENV.fetch('INSPECTOR', false)
  )
end
