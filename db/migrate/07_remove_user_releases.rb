class RemoveUserReleases < ActiveRecord::Migration
  def change
    drop_table :user_releases 
    add_column :releases, :user_id, :integer 
  end
end