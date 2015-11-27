class AddCollaboratorIdToInventories < ActiveRecord::Migration
  def change
    add_column :inventories, :collaborator_id, :integer
  end
end
