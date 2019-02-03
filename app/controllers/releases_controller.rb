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
      erb :'releases/show_detail'
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
        release.description = params["description"]
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

  #load release edit form
  get '/releases/:id/edit' do
    if logged_in?
      @release = Release.find(params[:id])
      erb :'releases/edit'
    else 
      redirect :'/'
    end
  end

  #update a release
  patch '/releases/:id/edit' do 
    if logged_in?
      if params["artist"] != "" && params["title"] != ""
        release = Release.find(params[:id])
        release.update(title: params["title"], artist: params["artist"], description: params["description"])
        redirect to "/releases/#{params[:id]}"
      else
        redirect to "/releases/#{params[:id]}/edit"
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
