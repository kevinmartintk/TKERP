class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :name
      t.string :brand
      t.string :writer
      t.string :edition
      t.string :editorial
      t.string :model
      t.integer :team
      t.integer :inventory_type
      t.attachment :image
      t.text :description
      t.integer :copies
      t.string :serie
      t.date :reg_date
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :inventories, :inventory_type
    add_index :collaborators, :deleted_at
  end
end
