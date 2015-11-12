class ChangeProspectReferences < ActiveRecord::Migration
  def change
    remove_column :prospects, :account_id
    add_column  :prospects, :account_id, :integer, foreign_key: { references: :collaborators }
  end
end
