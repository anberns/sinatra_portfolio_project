class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :artist
      t.string :title
      t.string :label
      t.string :genre
      t.integer :release_year
      t.integer :user_id
    end
  end
end