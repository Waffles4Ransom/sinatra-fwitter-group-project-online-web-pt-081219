require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'supernotsecretsecret'
  end

  get '/' do
    erb :index
  end 

  helpers do 

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(id: session[:user_id])
    end

    def authenticate
      if !logged_in?
        redirect '/login'
      end 
    end

    def authorized_user(tweet)
      authenticate
      redirect '/tweets' if !tweet 
      redirect '/tweets' if current_user != tweet.user
    end

  end 

end
