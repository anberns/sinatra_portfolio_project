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

  #load release create form
  get '/releases/new' do
    if logged_in?
      erb :'releases/new'
    else 
      redirect to '/'
    end
  end

  #load release details
  get '/releases/:id' do
    if logged_in?
      @release = Release.find(params[:id])
      erb :'releases/edit'
    else 
      redirect to '/'
    end
  end

  #create new release
  post '/releases' do 
    if logged_in?
      if params["artist"] != "" && params["title"] != ""
        album_hash = find_album_info(params["artist"], params["title"])
        release = Release.create(title: album_hash[:title], artist: album_hash[:artist])
        release.user_id = session[:user_id]
        release.save
        album_hash[:tracks].each do |track|
          new_track = Track.create(title: track)
          new_track.release_id = release.id 
          new_track.save
        end
        redirect to '/releases'
      else
        redirect to '/releases/new'
      end
    else
      redirect :'/'
    end
  end

  #delete release
  delete '/releases/:id/delete' do 
    if logged_in?
      release = Release.find(params[:id])
      if release.user_id == session[:user_id]
        Release.destroy(params[:id])
      end
      redirect to '/releases'
    else
      redirect to '/'
    end
  end

 

end
