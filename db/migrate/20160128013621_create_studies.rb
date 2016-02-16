class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.references :collaborator
      t.integer :type, null: false, default: 0
      t.integer :degree, null: false, default: 0
      t.date :start
      t.date :end
      t.references :entity
      t.attachment :certificate

      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :studies, :deleted_at
  end
end
