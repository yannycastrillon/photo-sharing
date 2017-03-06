class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.column "position", :integer
      t.column "photo_id", :integer
      t.column "slideshow_id", :integer
      t.timestamps null: false
    end
  end
end
