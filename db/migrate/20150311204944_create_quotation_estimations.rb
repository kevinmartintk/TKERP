class CreateQuotationEstimations < ActiveRecord::Migration
  def change
    create_table :quotation_estimations do |t|
      t.float :days_est, null: false, default:0
      t.float :hours_est, null: false, default:0
      t.float :price, null: false, default: 0
      t.integer :quotation_id, null: false
      t.integer :estimation_id, null: false
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :quotation_estimations, :deleted_at
  end
end
