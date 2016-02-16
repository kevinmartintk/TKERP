class CreateQuotationEstimations < ActiveRecord::Migration
  def change
    create_table :quotation_estimations do |t|
      t.references :quotation, null: false
      t.references :estimation, null: false
      t.boolean :selected

      #developers
      t.float :developer_days_est
      t.float :developer_hours_est
      t.float :developer_price

      #designers
      t.float :designer_days_est
      t.float :designer_hours_est
      t.float :designer_price

      #accounts
      t.float :account_hours_est
      t.float :account_price

      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :quotation_estimations, :deleted_at
  end
end
