class CreateProspectContacts < ActiveRecord::Migration
  def change
    create_table :prospect_contacts do |t|
      t.references :prospect, null: false
      t.references :contact, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end
   add_index :prospect_contacts, :deleted_at
  end
end
