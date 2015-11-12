class Prospect < ActiveRecord::Base
  include PgSearch
  belongs_to :client
  belongs_to :account, class_name: "Collaborator"
  has_many :estimations
  has_many :quotations
  has_many :prospect_contacts
  has_many :contacts, through: :prospect_contacts

  acts_as_paranoid

  accepts_nested_attributes_for :prospect_contacts, :allow_destroy => true
  validates :client, :prospect_contacts, presence: true

  delegate :name, :country_id, :to => :client, :prefix => true

  extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]

  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_client_name,  associated_against: {
                           client: [:name]},
                         using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_client_country,  associated_against: {
                           client: [:country_id] }

  def self.search_with name, company, status, type, country_id
    search_name(name).
    search_client_name(company).
    search_client_country(country_id).
    include_status(status).
    include_type(type)
  end

  def self.search_name name
    if name.present?
      seek_name(name)
    else
      order("created_at DESC")
    end       
  end

  def self.search_client_name company
    if company.present?
      seek_client_name(company)
    else
      order("created_at DESC")
    end
  end

  def self.search_client_country country_id
    if country_id.present?
      seek_client_country(country_id)
    else
      order("created_at DESC")
    end
  end

  def self.include_status status
    if status.present?
      where(status: status)
    else
      order("created_at DESC")
    end
  end

  def self.include_type type
    if type.present?
      where(prospect_type: type)
    else
      order("created_at DESC")
    end
  end

end
