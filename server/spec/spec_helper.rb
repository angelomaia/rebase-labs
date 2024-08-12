ENV['RACK_ENV'] ||= 'test'
ENV['DB_NAME'] ||= 'test_db'

require 'json'
require 'pg'
require 'sinatra'
require 'rack/test'
require_relative '../server'
require_relative '../config/db_config'

DB = PG.connect(DB_PARAMS)

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.formatter = :documentation

  config.before(:each) do
    DB.exec("TRUNCATE patients, doctors, tests, exams, test_exams RESTART IDENTITY;")
  end

  config.after(:each) do
    DB.exec("TRUNCATE patients, doctors, tests, exams, test_exams RESTART IDENTITY;")
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def app
  Sinatra::Application
end