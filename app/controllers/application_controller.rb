require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  def logged_in?
    if session[:user_id]
      true
    else
      false
    end
  end

  def current_user
    return User.find(session[:user_id])
  end

  def plusify(str)
    plussed = str.gsub(' ', '+')
  end

  def find_album_info(artist, title)
    html = open("https://www.discogs.com/search/?type=all&title=#{plusify(title)}&artist=#{plusify(artist)}&label=&track=&catno=&barcode=&anv=&format=&credit=&genre=&style=&country=&year=&submitter=&contributor=&matrix=&advanced=1")
    search_results = Nokogiri::HTML(html)

end
