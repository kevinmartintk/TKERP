class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :iso, null: false
      t.string :slug
      t.float :drawdown
      t.float :igv
    end
    add_index :countries, :slug, unique: true
  end
end