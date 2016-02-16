class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :name, null: false
      t.references :collaborator
      t.string :brand
      t.string :writer
      t.string :edition
      t.string :editorial
      t.string :model
      t.references :team
      t.integer :type, null: false, default: 0
      t.attachment :image
      t.text :description
      t.integer :quantity
      t.string :serie
      t.date :register_date
      t.string :cpu
      t.integer :ram
      t.integer :hdd
      t.integer :storage
      t.references :operating_system

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :inventories, :slug, unique: true
    add_index :inventories, :deleted_at
  end
end
