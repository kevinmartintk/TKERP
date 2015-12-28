class AddPartnerToClient < ActiveRecord::Migration
  def change
    add_reference :clients, :partner, index: true, foreign_key: false
  end
end
