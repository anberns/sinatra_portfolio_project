releases_list= {
    "Release 1" => {
      :artist => "Artist 1",
      :label => "Label 1",
      :genre => "techno",
      :release_year => 1999
    },
    "Release 2" => {
      :artist => "Artist 2",
      :label => "Label 2",
      :genre => "techno",
      :release_year => 2010 
    },
    "Release 3" => {
      :artist => "Artist 3",
      :label => "Label 3",
      :genre => "techno",
      :release_year => 2014
    }
  }

releases_list.each do |title, releases_hash|
  p = Release.new
  p.title = title 
  releases_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end

track_list = {
    "Track 1.1" => {
      :release_id => 1
    },
    "Track 1.2" => {
      :release_id => 1
    },
    "Track 1.3" => {
      :release_id => 1
    },
    "Track 2.1" => {
      :release_id => 2
    },
    "Track 2.2" => {
      :release_id => 2
    },
    "Track 3.1" => {
      :release_id => 3
    },
    "Track 3.2" => {
      :release_id => 3
    },
    "Track 3.3" => {
      :release_id => 3
    }
  }

track_list.each do |title, track_hash|
  p = Track.new
  p.title = title
  track_hash.each do |attribute, value|
    p[attribute] = value
  end
  p.save
end