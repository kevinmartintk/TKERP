class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :person
      t.references :client

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :contacts, :slug, unique: true
    add_index :contacts, :deleted_at
  end
end
