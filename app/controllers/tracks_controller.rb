class TracksController < ApplicationController

  #show all tracks in alpha order
  get '/tracks' do
    if logged_in?
      @tracks = Track.all.sort_by { |track| track.title }
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