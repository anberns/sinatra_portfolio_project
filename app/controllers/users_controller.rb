class UsersController < ApplicationController

  #load signup form
  get '/signup' do
    if logged_in?
      redirect to '/records'
    else
      erb :'users/signup'
    end
  end

  #login form
  get '/login' do 
    if logged_in?
      @user = current_user
      redirect to '/records'
    else
      erb :'users/login'
    end
  end

end