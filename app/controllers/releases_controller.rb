class ReleasesController < ApplicationController

  #load signup form
  get '/releases' do
    if logged_in?
      erb :'releases/show'
    else
      erb :'users/signup'
    end
  end

end
