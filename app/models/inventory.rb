class Inventory < ActiveRecord::Base
  include PgSearch
  belongs_to :inventory_type
  belongs_to :collaborator
  belongs_to :operating_system
  
  acts_as_paranoid

  has_attached_file :image, styles: { medium: "x180"}
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

  pg_search_scope :seek_code_or_name, against: [:id, :name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_description, against: [:description], using: { tsearch: { prefix: true  } }

  def code_inventory
    symbol = inventory_type.name.first
    symbol + ("%04d" % (id.to_s))
  end

  def self.search_with code_or_name, description, date, type, team
    search_code_or_name(code_or_name).
    search_description(description).
    include_register_date(date).
    include_type(type).
    include_team(team)
  end

  def self.search_code_or_name code_or_name
    if code_or_name.present?
      seek_code_or_name(code_or_name)
    else
      order("created_at DESC")
    end 
  end

  def self.search_description description
    if description.present?
      seek_description(description)
    else
      order("created_at DESC")
    end     
  end

  def self.include_register_date register_date
    if register_date.present?
      where("reg_date =?", register_date)
    else
      order("created_at DESC")
    end
  end

  def self.include_type type
    if type.present?
      where(inventory_type: type)
    else
      order("created_at DESC")
    end
  end

  def self.include_team team
    if team.present?
      where(team: team)
    else
      order("created_at DESC")
    end
  end
end
