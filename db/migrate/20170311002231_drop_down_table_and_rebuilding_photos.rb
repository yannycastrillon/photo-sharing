class DropDownTableAndRebuildingPhotos < ActiveRecord::Migration
  def change
    drop_table :photos
    create_table :photos do |t|
      t.column "filename", :string
      t.column "created_at", :datetime
      t.column "thumbnail",  :string
      t.column "description", :string
      t.timestamps null: false
    end
  end
end
