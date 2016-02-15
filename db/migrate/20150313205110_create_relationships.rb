class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :collaborator
      t.references :person
      t.integer :type, null: false, default: 0

      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :relationships, :deleted_at
  end
end
