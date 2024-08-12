require 'sinatra'
require 'faraday'
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