class AddPartialPaymentColumnToInvoice < ActiveRecord::Migration
  def change
  	 add_column :invoices, :partial_payment, :integer
  end
end
