class CreateProspectContacts < ActiveRecord::Migration
  def change
    create_table :prospect_contacts do |t|
      t.integer :prospect_id, null: false
      t.integer :contact_id, null: false
      t.datetime :deleted_at

      t.timestamps
    end
   add_index :prospect_contacts, :deleted_at

  end
end
