class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :collaborator_id, null: false
      t.timestamps null: false
    end
  end
end
