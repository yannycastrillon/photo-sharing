class AddColumnPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :description, :string
    add_column :photos, :thumbnail, :string
    Photo.all.each do |photo|
      photo.update_attribute :thumbnail, photo.filename.gsub('.','_m.')
    end
  end
end
