class AddPurchaseOrderColumnsToInvoice < ActiveRecord::Migration
  def self.up
    change_table :invoices do |t|
      t.attachment :purchase_order
    end
  end

  def self.down
    remove_attachment :invoices, :purchase_order
  end
end
