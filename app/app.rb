require 'sinatra'
require 'faraday'
require 'puma'
require 'faraday/multipart'
require 'json'

set :views, File.expand_path('../views', __FILE__)

get '/' do
  response = Faraday.get('http://exams-server:3000/tests')
  @tests = JSON.parse(response.body)

  erb :index
end

get '/:token' do
  token = params[:token]
  
  response = Faraday.get("http://exams-server:3000/tests/#{token}")
  @tests = JSON.parse(response.body)

  erb :index
end

post '/upload_csv' do
  if params[:file] && params[:file][:tempfile]
    conn = Faraday.new(url: 'http://exams-server:3000') do |f|
      f.request :multipart
      f.request :url_encoded
      f.adapter Faraday.default_adapter
    end

    payload = {
      file: Faraday::UploadIO.new(params[:file][:tempfile], 'text/csv')
    }

    response = conn.post('/import', payload)

    status response.status
    content_type :json
    response.body
  else
    status 400
    content_type :json
    { success: false }.to_json
  end
end

set :port, 4000
set :bind, '0.0.0.0'
set :server, :puma