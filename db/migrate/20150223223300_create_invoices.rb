class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.text :description, :null => false
      t.integer :currency, :null => false
      t.float :amount, :null => false
      t.integer :status, :null => false
      t.boolean :has_drawdown
      t.string :extra
      t.attachment :document, :null => true
      t.text :message
      t.string :slug
      t.integer :headquarter_id
      t.integer :client_id
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :invoices, :deleted_at
    add_index :invoices, :slug, unique: true
  end
end
