class ReleasesController < ApplicationController

  #show user releases
  get '/releases' do
    if logged_in?
      @user = current_user
      erb :'releases/show'
    else
      redirect to '/'
    end
  end

  #load release createform
  get '/releases/new' do
    if logged_in?
      erb :'releases/new'
    else 
      redirect to '/'
    end
  end

  #create new release
  post '/releases' do 
    if logged_in?
      if params["artist"] != "" && params["title"] != ""
        album_hash = find_album_info(params["artist"], params["title"])
        puts album_hash
        #release = Release.create(title: params["title"], artist: params["artist"], label: params["label"], genre: params["genre"], release_year: params["release_year"])
        #release.user_id = session[:user_id]
        #release.save
        redirect to '/releases'
      else
        redirect to '/releases/new'
      end
    else
      redirect :'/'
    end
  end

end
