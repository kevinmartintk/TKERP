class AddCalendarToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :calendar, :string
  end
end
