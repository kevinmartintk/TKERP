class CreateOperatingSystems < ActiveRecord::Migration
  def change
    create_table :operating_systems do |t|
      t.string :name
      t.integer :type, null: false, default: 0

      t.timestamps null: false
    end
  end
end
