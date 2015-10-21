class AddTeamToUser < ActiveRecord::Migration
  def change
    add_column :users, :team, :integer
  end
end
