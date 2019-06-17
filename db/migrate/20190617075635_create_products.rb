class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description
      t.string :image_url
      t.float :price

      t.timestamps
    end
  end
end
