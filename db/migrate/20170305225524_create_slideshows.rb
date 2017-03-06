class CreateSlideshows < ActiveRecord::Migration
  def change
    create_table :slideshows do |t|
      t.column "name", :string
      t.timestamps null: false
    end
  end
end
