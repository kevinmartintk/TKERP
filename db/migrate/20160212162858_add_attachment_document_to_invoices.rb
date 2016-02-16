class AddAttachmentDocumentToInvoices < ActiveRecord::Migration
  def self.up
    change_table :invoices do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :invoices, :document
  end
end
