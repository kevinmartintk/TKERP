class ChangeNameQuotationEstimationColumns < ActiveRecord::Migration
  def change
    rename_column :quotation_estimations, :design_days_est, :designer_days_est
    rename_column :quotation_estimations, :design_hours_est, :designer_hours_est
    rename_column :quotation_estimations, :design_price, :designer_price
  end
end
