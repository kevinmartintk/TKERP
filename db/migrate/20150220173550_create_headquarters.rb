class CreateHeadquarters < ActiveRecord::Migration
  def change
    create_table :headquarters do |t|
      t.attachment :image, :null => false
      t.integer :country_id
      t.timestamps
    end
  end
end