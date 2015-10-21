class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, :null => false
      t.string :address, :null => false
      t.string :legal_id, foreign_key: false, :unique => true
      t.string :slug
      t.integer :country_id
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :clients, :slug, unique: true
    add_index :clients, :deleted_at
  end
end
