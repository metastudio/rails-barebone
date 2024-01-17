# frozen_string_literal: true

require 'capybara/rspec'
require 'capybara/rails'
require 'selenium-webdriver'

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage window-size=1920,1024]
  )
  capabilities = [options, Selenium::WebDriver::Remote::Capabilities.chrome]
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: capabilities)
end

Capybara.javascript_driver = :chrome
Capybara.server = :puma, { Silent: true }
