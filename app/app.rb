require 'sinatra'
require 'faraday'
require 'json'

set :views, File.expand_path('../views', __FILE__)

get '/' do
  response = Faraday.get('http://exams-server:3000/tests')
  @tests = JSON.parse(response.body)

  erb :index
end
