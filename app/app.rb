require 'sinatra'
require 'faraday'
require 'json'

get '/' do
  response = Faraday.get('http://exams-server:3000/tests')
  @tests = JSON.parse(response.body)

  erb :index
end
