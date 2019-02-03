class ChangeReleases < ActiveRecord::Migration
  def change
    remove_column :releases, :genre, :string, null: false, default: ''
    remove_column :releases, :label, :string, null: false, default: ''
    remove_column :releases, :release_year, :integer, null: false, default: ''
    add_column :releases, :description, :string
  end
end