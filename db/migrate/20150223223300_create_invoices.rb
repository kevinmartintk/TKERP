class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.text :description, null: false
      t.references :currency, null: false
      t.float :amount, null: false
      t.integer :status, null: false, default: 0
      t.boolean :has_drawdown
      t.string :extra
      t.attachment :copy
      t.attachment :pdf
      t.attachment :purchase_order
      t.text :message
      t.text :reason
      t.references :headquarter
      t.references :client
      t.string :invoice_number
      t.date :expiration_date
      t.integer :payment_type, null: false, default: 0
      t.date :billing_date

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :invoices, :deleted_at
    add_index :invoices, :slug, unique: true
  end
end
