require 'sinatra'
require 'puma'
require 'json'
require_relative './services/query_service'

get '/tests' do
  content_type :json
  QueryService.fetch_all_tests
end

get '/tests/:token' do
  content_type :json
  QueryService.fetch_by_token(params[:token].upcase)
end

set :port, 3000
set :bind, '0.0.0.0'
set :server, :puma
