class Contact < ActiveRecord::Base
  include PgSearch
  acts_as_paranoid

  belongs_to :person
  belongs_to :client

  has_many :invoice_contacts
  has_many :prospect_contacts
  has_many :invoices, through: :invoice_contacts
  has_many :prospects, through: :prospect_contacts
  has_many :prospects


  delegate :name, to: :client, prefix: true, allow_nil: true
  delegate :name, :email, :phone, :mobile, :birthday, to: :person

  validates_associated :person, :client

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_client_name,  associated_against: {client: [:name]},using: {tsearch: {prefix: true}}


  def self.search_with name, company
    search_name(name).
    search_client_name(company)
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

  def slug_candidates
    if person_id.present?
      [
        person.name
      ]
    else
      nil
    end
  end

end