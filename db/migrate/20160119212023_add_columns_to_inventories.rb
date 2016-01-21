class AddColumnsToInventories < ActiveRecord::Migration
  def change
    add_column :inventories, :cpu, :string
    add_column :inventories, :ram, :integer
    add_column :inventories, :hdd, :integer
    add_column :inventories, :storage, :integer
    add_reference :inventories, :operating_system, index: true
  end
end