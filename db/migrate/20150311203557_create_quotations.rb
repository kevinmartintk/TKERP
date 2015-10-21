class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.integer :prospect_id, null: false
      t.float :price_per_hour, null: false, default: 0
      t.float :total, null: false, default: 0

      t.timestamps null: false
    end
  end
end