class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :entity
      t.references :partner, references: :clients
      t.integer :type, null: false, default: 0

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :clients, :slug, unique: true
    add_index :clients, :deleted_at
  end
end
