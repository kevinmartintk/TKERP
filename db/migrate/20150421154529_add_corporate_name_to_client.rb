class AddCorporateNameToClient < ActiveRecord::Migration
  def change
  	add_column :clients, :corporate_name, :string
  end
end
