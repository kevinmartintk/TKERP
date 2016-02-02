class CreateInvoiceContacts < ActiveRecord::Migration
  def change
    create_table :invoice_contacts do |t|
      t.references :invoice
      t.references :contact

      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :invoice_contacts, :deleted_at
  end
end