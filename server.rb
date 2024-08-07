require 'sinatra'
require 'puma'
require 'csv'
require 'pg'
require 'json'
require './config/db_config'

get '/tests' do
  content_type :json

  conn = PG.connect(DB_PARAMS)
  result = conn.exec("SELECT * FROM imported_data")

  data = result.map do |row|
    row
  end

  data.to_json
end

set :port, 3000
set :bind, '0.0.0.0'
set :server, :puma
