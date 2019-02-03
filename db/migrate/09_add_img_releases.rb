class AddImgReleases< ActiveRecord::Migration
  def change
    add_column :releases, :img_link, :string
  end
end