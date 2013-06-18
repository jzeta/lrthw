require_relative "gothonweb/version"
require_relative "map"
require "sinatra"
require "erb"
require "rubygems"

#module Gothonweb

  use Rack::Session::Pool

  get '/' do
    # this is used to "setup" the session with starting values
    game = Game.new()
    start = game.start
    p start
    session[:room] = start
    redirect("/game")
  end

  get '/game' do
    if session[:room]
      erb :show_room, :locals => {:room => session[:room]}
    else
      # why is this here? do you need it?
      erb :you_died
    end
  end

  post '/game' do
    action = "#{params[:action] || '*'}"
    # there is a bug here, can you fix it?
    if session[:room]
      session[:room] = session[:room].go(params[:action])
    end
    redirect("/game")
  end

  get '/count' do
    session[:count] ||= 0
    session[:count] +=1
    "Count: #{session[:count]}"
  end

  get '/reset' do
    session.clear
    "Count reset to 0."
  end
#end
