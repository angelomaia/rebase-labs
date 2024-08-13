ENV['RACK_ENV'] ||= 'test'

require 'json'
require 'sinatra'
require 'rack/test'
require 'faraday'
require 'capybara/rspec'
require 'capybara/cuprite'

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, browser_options: { 'no-sandbox': nil })
end

Capybara.javascript_driver = :cuprite
Capybara.app = Sinatra::Application

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