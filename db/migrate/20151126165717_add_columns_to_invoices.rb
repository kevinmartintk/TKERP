class AddColumnsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :expiration_date, :date
    add_column :invoices, :payment_type, :integer
  end
end
