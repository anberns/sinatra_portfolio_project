class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :tweets, :tracks 
  end
end