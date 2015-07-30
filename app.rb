require 'sinatra/activerecord'
require 'sinatra'
require_relative 'environment'

get '/' do
  redirect '/colors'
end

get '/colors' do
  "hello colors"
end

