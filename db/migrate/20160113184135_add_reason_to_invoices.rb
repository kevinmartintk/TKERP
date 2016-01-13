class AddReasonToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :reason, :text
  end
end
