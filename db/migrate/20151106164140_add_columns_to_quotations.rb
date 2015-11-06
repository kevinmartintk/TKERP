class AddColumnsToQuotations < ActiveRecord::Migration
  def change
    rename_column :quotations, :price_per_hour, :developer_price_per_hour
    add_column :quotations, :designer_price_per_hour, :float
    add_column :quotations, :account_price_per_hour, :float
  end
end
