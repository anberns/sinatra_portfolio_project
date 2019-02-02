class UserRelease < ActiveRecord::Base
  belongs_to :user
  belongs_to :release 
end
