require 'sinatra'
require 'puma'
require 'json'
require_relative './services/query_service'
require_relative './services/csv_importer'
require_relative './services/csv_validator'

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
  validation_response = CSVValidator.validate(file)
  result = JSON.parse(validation_response, symbolize_names: true)

  if result[:success]
    importer = CSVImporter.new(DB_PARAMS, file)
    importer.import
    status 200
    { success: true }.to_json
  else
    status 400
    result.to_json
  end
end

set :port, 3000
set :bind, '0.0.0.0'
set :server, :puma
