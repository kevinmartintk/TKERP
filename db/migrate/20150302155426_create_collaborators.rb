class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|

      # general info
      t.references :person, null: false

      # internal info
      t.references :team
      t.string :code
      t.date :first_day
      t.references :boss, references: :collaborators
      t.string :work_mail
      t.integer :type, null: false, default: 0
      t.integer :status, null: false, default: 0

      # bank info
      t.float :salary

      # health info
      t.integer :blood_type, null: false, default: 0
      t.string :allergies
      t.boolean :disability
      t.attachment :before_employment_test
      t.attachment :around_employment_test
      t.attachment :after_employment_test

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :collaborators, :deleted_at
    add_index :collaborators, :slug, unique: true
  end
end
