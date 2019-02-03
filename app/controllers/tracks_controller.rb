class TracksController < ApplicationController

  #show all tracks in alpha order
  get '/tracks' do
    if logged_in?
      @tracks = Track.all.sort_by { |track| track.title }
      erb :'tracks/show'
    else
      redirct to '/users/signup'
    end
  end
end