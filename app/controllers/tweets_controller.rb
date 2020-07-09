class TweetsController < ApplicationController

  get '/tweets' do 
    authenticate
    @tweets = Tweet.all
    @users = User.all
    erb :'tweets/index'
  end 

  get '/tweets/new' do
    authenticate
    erb :'/tweets/new'
  end 

  post '/tweets' do 
    redirect '/tweets/new' if params[:content].empty?
    tweet = current_user.tweets.build(params)
    if tweet.save
      redirect '/tweets'
    else
      erb :'/tweets/new'
    end
  end

  get '/tweets/:id' do 
    authenticate
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet
      erb :'tweets/show'
    else
      redirect '/tweets'
    end 
  end 

  get '/tweets/:id/edit' do 
    authenticate
    @tweet = Tweet.find_by(id: params[:id])
    authorized_user(@tweet)
    erb :'/tweets/edit'
  end 

  post '/tweets/:id' do
    redirect "/tweets/#{params[:id]}/edit" if params[:content].empty?
    @tweet = Tweet.find_by(id: params[:id])
    authorized_user(@tweet)
    @tweet.update(content: params[:content])
    
    if @tweet.errors.any?
      erb :'/tweets/edit'
    else
      redirect '/tweets'
    end
  end 

  delete '/tweets/:id/delete' do 
    authenticate
    tweet = Tweet.find_by(id: params[:id])
    authorized_user(tweet)
    if tweet 
      tweet.destroy 
      redirect '/tweets'
    end
  end 


end
