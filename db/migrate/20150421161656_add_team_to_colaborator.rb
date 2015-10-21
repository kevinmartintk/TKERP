class AddTeamToColaborator < ActiveRecord::Migration
  def change
  	add_column :collaborators, :team, :integer 
  end
end
