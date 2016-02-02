class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.references :prospect, null: false
      t.float :developer_price_per_hour
      t.float :designer_price_per_hour, :float
      t.float :account_price_per_hour, :float
      t.float :total
      t.references :currency

      t.string :slug
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :quotations, :slug, unique: true
    add_index :quotations, :deleted_at
  end
end