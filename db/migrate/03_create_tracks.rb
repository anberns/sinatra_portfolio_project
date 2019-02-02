class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :title
      t.integer :release_id
    end
  end
end
