class AddPositionAndExtensionToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :position, :string
    add_column :contacts, :extension, :integer
  end
end
