class UsersController < ApplicationController

  #load signup form
  get '/signup' do
    if logged_in?
      redirect to '/releases'
    else
      @message = " "
      erb :'users/signup'
    end
  end

  #create new user
  post '/signup' do 
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect '/signup'
    elsif User.find_by(username: params[:username])
      @message = "Username already exists, please choose another."
      erb :'users/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/releases'
    end
  end

  #login form
  get '/login' do 
    if logged_in?
      @user = current_user
      redirect to '/releases'
    else
      erb :'users/login'
    end
  end

  #login user
  post '/login' do 
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/releases'
    else 
      redirect to '/'
    end
  end

  #logout user 
  get '/logout' do 
    if logged_in?
      session.clear
    end
    redirect to '/'
  end

end