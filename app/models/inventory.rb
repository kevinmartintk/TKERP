class Inventory < ActiveRecord::Base
  belongs_to :inventory_type

  acts_as_paranoid

  has_attached_file :image, styles: { medium: "x180"}
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

  searchable do
    string :code do |inventory|
      inventory.inventory_type.name.first+("%04d" % (inventory.id.to_s))
    end
    string :name
    integer :inventory_type_id
    integer :team
    text :description
    date :reg_date
  end

  def code_inventory
    symbol = inventory_type.name.first
    symbol + ("%04d" % (id.to_s))
  end
end
