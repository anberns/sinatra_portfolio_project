class Release < ActiveRecord::Base
  has_many :tracks
  belongs_to :user

  def self.plusify(str)
    plussed = str.gsub(' ', '+')
  end

  def self.find_album_info(artist, title)
    html = open("https://www.discogs.com/search/?type=all&title=#{plusify(title)}&artist=#{plusify(artist)}&label=&track=&catno=&barcode=&anv=&format=&credit=&genre=&style=&country=&year=&submitter=&contributor=&matrix=&advanced=1")
    search_results = Nokogiri::HTML(html)
    release = search_results.css("div.shortcut_navigable")[0]
    url = release.css("a")[0].attribute("href").value
    full_url = "https://www.discogs.com" + url 
    image_a = search_results.css("a.thumbnail_link")
    image_span = image_a.css("span.thumbnail_center")
    image_url = image_span.css("img").attribute("data-src").value
    release_info = Nokogiri::HTML(open(full_url))
    release_hash = {
      :title => title,
      :artist => artist,
      :img_link => image_url
    }
    tracks = release_info.css("span.tracklist_track_title")
    track_array = tracks.collect do |track|
      track.text
    end
    release_hash[:tracks] = track_array 
    release_hash
    
  end

end
