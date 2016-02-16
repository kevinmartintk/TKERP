class CreateJobExperiences < ActiveRecord::Migration
  def change
    create_table :job_experiences do |t|
      t.references :collaborator, null: false
      t.integer :type, null: false, default: 0
      t.references :entity, null: false
      t.references :position
      t.date :start
      t.date :end
      t.text :achievements
      t.text :functions
      t.attachment :certificate
      t.references :reference, references: :people

      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :job_experiences, :deleted_at
  end
end
