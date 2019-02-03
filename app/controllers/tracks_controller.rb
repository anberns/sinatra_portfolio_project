class TracksController < ApplicationController

  #show all tracks in alpha order
  get '/tracks' do
    if logged_in?
      user_releases = current_user.releases
      user_tracks = [] 
      user_releases.each do |release|
        release.tracks.each do |track|
          user_tracks << track
        end
      end
      @tracks = user_tracks.sort_by { |track| track.title }
      erb :'tracks/show'
    else
      redirect to '/'
    end
  end

  get '/tracks/delete' do
    if logged_in?
      Track.find_each(&:destroy)
      erb :'tracks/show'
    else
      redirect to '/'
    end
  end
end