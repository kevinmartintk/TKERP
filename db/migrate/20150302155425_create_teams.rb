class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.references :leader, foreign_key: false
      t.references :parent, references: :teams
      t.date :start
      t.date :end

      t.string :slug
      t.datetime :deleted_at
      t.timestamp null: false
    end
    add_index :teams, :slug, unique: true
    add_index :teams, :deleted_at
  end
end
