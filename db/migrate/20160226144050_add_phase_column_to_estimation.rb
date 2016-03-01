class AddPhaseColumnToEstimation < ActiveRecord::Migration
  def change
  	 add_column :estimations, :status, :integer
  end
end
