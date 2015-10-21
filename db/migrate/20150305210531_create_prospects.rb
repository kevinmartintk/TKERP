class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.integer :client_id
      t.integer :country_id
      t.integer :prospect_type
      t.integer :account_id, foreign_key: { references: :users }
      t.integer :team
      t.integer :status
      t.string :observation
      t.date :approved_at
      t.string  :name
      t.date :arrival_date
      t.date :arrival_team_date
      t.datetime :deleted_at
      t.string :slug
      t.timestamps
    end
    add_index :prospects, :deleted_at
    add_index :prospects, :slug, unique: true
  end
end
