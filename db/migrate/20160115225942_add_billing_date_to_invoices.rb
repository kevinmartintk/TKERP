class AddBillingDateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :billing_date, :date
  end
end
