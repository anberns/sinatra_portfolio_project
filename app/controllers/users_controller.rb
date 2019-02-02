class UsersController < ApplicationController

  #load signup form
  get '/signup' do
    if logged_in?
      redirect to '/collection'
    else
      erb :'users/signup'
    end
  end

  #create new user
  post '/signup' do 
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect '/signup'
    else
      @user = User.create(username: params["username"], email: params["email"], password_digest: params["password"])
      session[:user_id] = @user.id
      redirect '/collection'
    end
  end

  #login form
  get '/login' do 
    if logged_in?
      @user = current_user
      redirect to '/collection'
    else
      erb :'users/login'
    end
  end

  #login user
  post '/login' do 
    user = User.find_by(username: params["username"])
    if user.authenticate(params["password"])
      session[:user_id] = user.id
      redirect '/collection'
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

  #show user releases
  get '/collection' do
    if logged_in?
      @user = current_user
      erb :'users/show'
    else
      redirect to '/'
    end
  end

end