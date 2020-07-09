class SessionsController < ApplicationController

  get '/login' do 
    redirect '/tweets' if logged_in?
    erb :'/sessions/login'
  end

  post '/login' do 
    user = User.find_by(username: params[:username])
    if !!user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else 
      @error = "Invalid attempt, please try again."
      erb :'sessions/login'
    end 
  end 

  get '/signup' do
    redirect '/tweets' if logged_in?
    erb :'sessions/signup'
  end 

  post '/signup' do 
    redirect '/signup' if params[:username].empty? || params[:password].empty? || params[:email].empty?
    @user = User.create(email: params[:email], username: params[:username], password: params[:password])
    if @user.errors.any?
      erb :'sessions/signup'
    else
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end 

  get '/logout' do 
    session.destroy if logged_in? 
    redirect to '/login'
  end 

  delete '/logout' do 
    session.clear
    redirect '/login'
  end

end 