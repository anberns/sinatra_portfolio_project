class ReleasesController < ApplicationController

  #show user releases
  get '/releases' do
    if !logged_in?
      redirect to '/'
    end

    @user = current_user
    erb :'releases/index'
  end

  #load release create form
  get '/releases/new' do
    if !logged_in?
      redirect to '/'
    end

    erb :'releases/new'
  end

  #load release details
  get '/releases/:id' do
    if !logged_in?
      redirect to '/'
    end

    @release = Release.find(params[:id])
    erb :'releases/show'
  end

  #create new release
  post '/releases' do 
    begin
      if !logged_in?
        redirect to '/'
      end

      if params["artist"] == "" || params["title"] == ""
        redirect to '/releases/new'
      end

      album_hash = Release.find_album_info(params["artist"], params["title"])
      release = Release.create(title: album_hash[:title], description: params["description"], artist: album_hash[:artist], img_link: album_hash[:img_link], user_id: session[:user_id])
      album_hash[:tracks].each do |track|
        new_track = Track.create(title: track, release_id: release.id)
      end
      redirect to '/releases'

    rescue
      @message = "There was a problem retrieving album information."
      erb :error
    end
  end

  #load release edit form
  get '/releases/:id/edit' do
    if !logged_in?
      redirect to '/'
    end

    @release = Release.find(params[:id])
    if @release.user_id == current_user.id
      erb :'releases/edit'
    else 
      @message = "You are not authorized to edit this album."
      erb :'error'
    end

  end

  #update a release
  patch '/releases/:id' do 
    if !logged_in?
      redirect to '/'
    end

    if params["artist"] == "" || params["title"] == ""
      redirect to "/releases/#{params[:id]}/edit"
    end

    release = Release.find(params[:id])
    if release.user_id == current_user.id 
      release.update(title: params["title"], artist: params["artist"], description: params["description"])
      redirect to "/releases/#{params[:id]}"
    else 
      @message = "You are not authorized to edit this album."
      erb :'error'
    end
  end

  #delete release
  delete '/releases/:id' do 
    if !logged_in?
      redirect to '/'
    end

    release = Release.find(params[:id])
    if release.user_id == session[:user_id]
      release.tracks.each do |track|
        Track.destroy(track.id)
      end
      Release.destroy(params[:id])
    end
    redirect to '/releases'

  end

 

end
