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

  delegate :name, to: :client, prefix: true
  delegate :name, to: :person, prefix: true
  delegate :name, :email, :phone, :mobile, :birthday, :full_name, to: :person

  validates :client, presence: true

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]


  pg_search_scope :seek_first_name, associated_against: { person: [:first_name] }, using: { tsearch: { prefix: true }}
  pg_search_scope :seek_last_name, associated_against: { person: [:last_name] }, using: { tsearch: { prefix: true }}
  pg_search_scope :seek_name, associated_against: 
                            { person: [:name] }, using: { tsearch: { prefix: true  } }
  #pg_search_scope :seek_client_name,  associated_against: {client: [:name]},using: {tsearch: {prefix: true}}
  scope :from_client , ->  ( client_id ) { where(client_id: client_id)}

  def self.search_with name, company
    search_name(name)
    #search_client_name(company)
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
    [
      person.name
    ]
  end

  def belongs_to_invoice invoice_id
    if invoice_id.present?
      invoice = Invoice.find(invoice_id)
      invoice.contacts.include? self
    end
  end

end