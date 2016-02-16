class CreateHeadquarters < ActiveRecord::Migration
  def change
    create_table :headquarters do |t|
      t.attachment :image
      t.references :country

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :headquarters, :slug, unique: true
    add_index :headquarters, :deleted_at
  end
end