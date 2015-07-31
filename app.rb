require 'sinatra/activerecord'
require 'sinatra'
require_relative 'environment'

# helpers do
#   def hello
#     puts "Hello"
#   end
# end

get '/' do
  redirect '/colors'
end

get '/colors' do
  @colors = Color.all.order(:vote_count => :asc)
  erb :'colors/index'
end


get '/nocss' do
  @skip_css = true
  @colors = Color.all.order(:vote_count => :asc)
  erb :'colors/index'
end  
