class User < ActiveRecord::Base
  has_secure_password
  has_many :user_releases
  has_many :releases, through: :user_releases
  has_many :tracks, through: :releases

  def slug
    @slugged = self.username.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    User.all.find do |user| 
      user.slug == slug 
    end
  end
end