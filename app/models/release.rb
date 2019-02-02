class Release < ActiveRecord::Base
  has_many :tracks
  has_many :user_releases
  has_many :users, through: :user_releases
end
