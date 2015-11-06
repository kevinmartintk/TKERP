class AddColumnsToQuotationEstimation < ActiveRecord::Migration
  def change
    rename_column :quotation_estimations, :days_est, :developer_days_est
    rename_column :quotation_estimations, :hours_est, :developer_hours_est
    rename_column :quotation_estimations, :price, :developer_price
    add_column :quotation_estimations, :design_days_est, :float
    add_column :quotation_estimations, :design_hours_est, :float
    add_column :quotation_estimations, :design_price, :float
    add_column :quotation_estimations, :account_hours_est, :float
    add_column :quotation_estimations, :account_price, :float
  end
end
