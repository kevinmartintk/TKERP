class ChangeNameEstimationColumns < ActiveRecord::Migration
  def change
    rename_column :estimations, :design_hours, :designer_hours
    rename_column :estimations, :design_hours_per_day, :designer_hours_per_day
    rename_column :estimations, :design_days, :designer_days
  end
end
