class AddSelectedToQuotationEstimations < ActiveRecord::Migration
  def change
    add_column :quotation_estimations, :selected, :boolean
  end
end
