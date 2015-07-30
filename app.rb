require 'sinatra'

get '/' do
  redirect '/colors'
end

get '/colors' do
  "hello colors"
end

