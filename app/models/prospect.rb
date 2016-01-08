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

  delegate :name, :type, :country_id, :to => :client, :prefix => true
  delegate :partner_name, :to => :client

  extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]

  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_client_name,  associated_against: {
                           client: [:name]},
                         using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_client_country,  associated_against: {
                           client: [:country_id] }
  pg_search_scope :seek_client_partner,  associated_against: {
                           client: [:partner_id] }

  scope :partner, -> { joins('JOIN "clients" ON "clients"."id" = "prospects"."client_id" AND "clients"."deleted_at" IS NULL').merge(Client.partner) }
  scope :regular, -> { joins('JOIN "clients" ON "clients"."id" = "prospects"."client_id" AND "clients"."deleted_at" IS NULL').merge(Client.regular) }

  def self.search_with name, company, status, prospect_type, country_id, client_type, partner_id
    include_client_type(client_type).
    include_status(status).
    include_prospect_type(prospect_type).
    search_name(name).
    search_client_name(company).
    search_client_country(country_id).
    search_client_partner(partner_id)
  end

  def self.search_client_partner(partner_id)
    if partner_id.present?
      seek_client_partner(partner_id)
    else
      order("created_at DESC")
    end
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

  def self.include_prospect_type prospect_type
    if prospect_type.present?
      where(prospect_type: prospect_type)
    else
      order("created_at DESC")
    end
  end

  def self.include_client_type client_type
    if client_type.present?
       send(client_type)
    else
      order("created_at DESC")
    end
  end

end
