class AddInvoicePdfColumnsToInvoice < ActiveRecord::Migration
  def self.up
    change_table :invoices do |t|
      t.attachment :invoice_pdf
    end
  end

  def self.down
    remove_attachment :invoices, :invoice_pdf
  end
end
