class AddInventoryTypeRefToInventories < ActiveRecord::Migration
  def change
  	rename_column :inventories, :inventory_type, :inventory_type_id
  end
end
