class CreateEstimations < ActiveRecord::Migration
  def change
    create_table :estimations do |t|
      t.references :prospect, null: false
      t.references :technology
      t.integer :type, null: false, default: 0
      t.date :sent_at

      #developers
      t.integer :developers
      t.float :developer_days
      t.float :developer_hours
      t.float :developer_hours_per_day

      #designers
      t.integer :designers
      t.float :designer_days
      t.float :designer_hours
      t.float :designer_hours_per_day

      #accounts
      t.integer :accounts
      t.float :account_hours

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :estimations, :slug, unique: true
    add_index :estimations, :deleted_at
  end
end
