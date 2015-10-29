class Client < ActiveRecord::Base
  include PgSearch
  acts_as_paranoid
  belongs_to	:country
  has_many :contacts
  has_many :prospects
  has_many :invoices, :dependent => :restrict_with_error
  validates :name, :country, :address, presence: true

  validates :legal_id, presence: true, if: :is_peruvian?
  validates :legal_id , length: {is: 11}, uniqueness:true, if: :is_peruvian?

  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_legal_id, against: [:legal_id], using: { tsearch: { prefix: true  } }

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def is_peruvian?
    country_id.eql?(173)
  end

  def self.search_with name, legal_id
    search_name(name).
    search_legal_id(legal_id)
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
  
end