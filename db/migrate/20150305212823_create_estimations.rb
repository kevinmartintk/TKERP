class CreateEstimations < ActiveRecord::Migration
  def change
    create_table :estimations do |t|
      t.integer :prospect_id
      t.integer :technology_id
      t.integer :estimation_type
      t.integer :developers
      t.float :days
      t.float :hours
      t.float :hours_per_day
      t.date :sent_at
      t.timestamps null: false
    end
  end
end
