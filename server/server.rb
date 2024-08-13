require 'sinatra'
require 'puma'
require 'json'
require_relative './services/query_service'
require_relative './services/csv_importer'

get '/tests' do
  content_type :json
  QueryService.fetch_all_tests
end

get '/tests/:token' do
  content_type :json
  QueryService.fetch_by_token(params[:token].upcase)
end

post '/import' do
  file = params[:file][:tempfile]
  importer = CSVImporter.new(DB_PARAMS, file)
  importer.import
  { success: true }.to_json
end

set :port, 3000
set :bind, '0.0.0.0'
set :server, :puma
