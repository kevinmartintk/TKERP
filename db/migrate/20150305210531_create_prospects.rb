class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.references :client, null: false
      t.references :account, references: :collaborators
      t.references :country
      t.integer :type, null: false, default: 0
      t.references :team
      t.integer :status, null: false, default: 0
      t.string :observation
      t.date :approved_at
      t.string :name, null: false
      t.date :arrival_date
      t.date :arrival_team_date

      t.datetime :deleted_at
      t.string :slug
      t.timestamps null: false
    end
    add_index :prospects, :deleted_at
    add_index :prospects, :slug, unique: true
  end
end
