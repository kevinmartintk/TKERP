class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :dni
      t.attachment :dni_scan
      t.date :birthday
      t.string :email
      t.integer :civil_status, null: false, default: 0
      t.string :address
      t.integer :district
      t.integer :gender
      t.string :phone
      t.string :mobile
      t.string :skype
      t.attachment :certificate
      t.references :position
      t.integer :extension

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :people, :deleted_at
    add_index :people, :slug, unique: true
  end
end
