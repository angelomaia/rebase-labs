ENV['RACK_ENV'] ||= 'test'

require 'json'
require 'sinatra'
require 'rack/test'
require 'faraday'
require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.formatter = :documentation
  config.include Capybara::DSL

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage]))
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :headless_chrome
Capybara.app = Sinatra::Application
Capybara.server = :webrick