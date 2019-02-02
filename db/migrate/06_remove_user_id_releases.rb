class RemoveUserIdReleases < ActiveRecord::Migration
  def change
    remove_column :releases, :user_id, :integer, null: false, default: ''
  end
end
