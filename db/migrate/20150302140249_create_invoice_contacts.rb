class CreateInvoiceContacts < ActiveRecord::Migration
  def change
    create_table :invoice_contacts do |t|
    	t.integer :invoice_id
    	t.integer :contact_id
    	t.datetime :deleted_at

      t.timestamps
    end
    add_index :invoice_contacts, :deleted_at
  end
end