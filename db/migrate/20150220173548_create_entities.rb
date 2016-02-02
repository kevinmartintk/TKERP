class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name
      t.string :corporate_name, null: false
      t.string :address
      t.string :phone
      t.string :legal_id, foreign_key: false
      t.references :country
      t.integer :type, null: false, default: 0

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :entities, :slug, unique: true
    add_index :entities, :deleted_at
  end
end
