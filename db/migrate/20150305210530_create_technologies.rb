class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :name

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :technologies, :slug, unique: true
    add_index :technologies, :deleted_at
  end
end
