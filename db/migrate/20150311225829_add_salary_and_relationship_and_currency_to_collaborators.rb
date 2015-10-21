class AddSalaryAndRelationshipAndCurrencyToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :salary, :float, null: false
    add_column :collaborators, :relationship, :integer, null:false
    add_column :collaborators, :currency, :integer, null: false
  end
end
