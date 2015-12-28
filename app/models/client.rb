class Client < ActiveRecord::Base
  include PgSearch
  acts_as_paranoid

  belongs_to :country
  belongs_to :partner, class_name: "Client", foreign_key: "partner_id"

  has_many :clients, class_name: "Client", foreign_key: "partner_id"
  has_many :contacts
  has_many :prospects
  has_many :invoices, :dependent => :restrict_with_error

  validates :name, :country, :address, presence: true
  validates :legal_id, presence: true, if: :is_peruvian?
  validates :legal_id , length: {is: 11}, uniqueness:true, if: :is_peruvian?

  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_legal_id, against: [:legal_id], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_partner_id, against: [:partner_id], using: { tsearch: { prefix: true  } }

  scope :partner, -> { select("DISTINCT clients.*").joins("JOIN clients partners_clients ON clients.id = partners_clients.partner_id AND partners_clients.deleted_at IS NULL") }
  scope :regular, -> { select("DISTINCT clients.*").joins("JOIN clients partners_clients ON clients.id != partners_clients.partner_id AND partners_clients.deleted_at IS NULL") }
  scope :all_except, ->(client) { where.not(id: client) }

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def type
    (clients.empty?) ? "Regular" : "Partner"
  end

  def is_peruvian?
    country_id.eql?(173)
  end

  def self.search_with name, legal_id, type, partner_id
    search_name(name).
    search_legal_id(legal_id).
    search_type(type).
    search_partner(partner_id)
  end

  def self.search_name name
    if name.present?
      seek_name(name)
    else
      order("created_at DESC")
    end       
  end

  def self.search_legal_id legal_id
    if legal_id.present?
      seek_legal_id(legal_id)
    else
      order("created_at DESC")
    end       
  end

  def self.search_type type
    if type.present?
      (type == "true") ? partner : regular
    else
      order("created_at DESC")
    end
  end

  def self.search_partner partner_id
    if partner_id.present?
      seek_partner_id(partner_id)
    else
      order("created_at DESC")
    end
  end
  
end