class User < ActiveRecord::Base
  has_secure_password
  has_many :user_releases
  has_many :releases, through: :user_releases
  has_many :tracks, through: :releases
end