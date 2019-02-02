class CreateUserReleases < ActiveRecord::Migration
  def change
    create_table :user_releases do |t|
      t.integer :user_id
      t.integer :release_id
    end
  end
end