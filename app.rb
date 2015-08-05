require 'sinatra/activerecord'
require 'sinatra'
require "sinatra/cookies"

require_relative 'environment'

helpers do
  def selected_ids_from_cookie
    return [] if cookies[:selected_color_ids].nil?
    cookies[:selected_color_ids].split(',')
  end

  def selected_id_remember(id)
    sel = selected_ids_from_cookie
    sel.push id.to_s unless sel.include?(id)
    sel.sort!
    cookies[:selected_color_ids]= sel.join(',')
  end
  
  def selected_id_forget(id)
    sel = selected_ids_from_cookie
    sel.delete id.to_s
    sel.sort!
    cookies[:selected_color_ids]= sel.join(',')
  end

  def selected_id_remembered?(id)
    selected_ids_from_cookie.include?(id.to_s)
  end

  def active_page?(path)
    request.path_info == path
  end
end

get '/' do
  redirect '/colors'
end

get '/colors' do
  @colors = Color.all.shuffle
  selected = selected_ids_from_cookie
  @colors.each do |color|
    color.selected = selected.include?(color.id.to_s)
  end

  erb :'colors/index'
end

get '/board' do
  @colors = Color.all.order(:vote_count => :desc).limit(20)
  erb :'colors/board'
end


get '/nocss' do
  @skip_css = true
  @colors = Color.all.order(:vote_count => :asc)
  erb :'colors/index'
end  

before '/color/:color_id/*' do
  @color = Color.find(params[:color_id])
end

post '/color/:color_id/vote' do
  unless selected_id_remembered?(@color.id)
    @color.add_vote 
    selected_id_remember(@color.id)
  end

  if request.xhr?
    content_type :json
    @color.to_json
  else
    redirect '/colors'
  end  
end

post '/color/:color_id/unvote' do
  if selected_id_remembered?(@color.id)
    @color.remove_vote 
    selected_id_forget(@color.id)
  end

  if request.xhr?
    content_type :json
    @color.to_json
  else
    redirect '/colors'
  end  
end
