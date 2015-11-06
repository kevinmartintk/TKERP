class AddColumnsToEstimation < ActiveRecord::Migration
  def change
    rename_column :estimations, :days, :developer_days
    rename_column :estimations, :hours, :developer_hours
    rename_column :estimations, :hours_per_day, :developer_hours_per_day
    add_column :estimations, :designers, :integer
    add_column :estimations, :accounts, :integer
    add_column :estimations, :design_days, :integer
    add_column :estimations, :design_hours, :integer
    add_column :estimations, :design_hours_per_day, :integer
    add_column :estimations, :account_hours, :integer
  end
end
