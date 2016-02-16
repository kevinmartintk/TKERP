class CreateCollaboratorEntities < ActiveRecord::Migration
  def change
    create_table :collaborator_entities do |t|
      t.references :collaborator, null: false
      t.references :entity, null: false
      t.integer :type, null: false, default: 0
      t.string :account_number

      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :collaborator_entities, :deleted_at
  end
end
