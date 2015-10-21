class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :last_name
      t.string :dni
      t.date :birthday
      t.string :mail
      t.string :mobile
      t.string :skype
      t.string :em_number
      t.string :contact
      t.string :address
      t.date :start_day
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :collaborators, :deleted_at
  end
end
