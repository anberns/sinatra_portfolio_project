class ReleasesController < ApplicationController

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
