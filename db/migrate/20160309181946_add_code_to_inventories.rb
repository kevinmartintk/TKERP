class AddCodeToInventories < ActiveRecord::Migration
  def change
    add_column :inventories, :code, :string
  end
end
