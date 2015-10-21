class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, :null => false
      t.string  :email, :null => false
      t.string :phone, :null => false
      t.string :mobile
      t.date    :birthday
      t.string  :slug
      t.integer :client_id
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :contacts, :slug, unique: true
    add_index :contacts, :deleted_at
  end
end
