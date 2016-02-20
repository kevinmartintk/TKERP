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

<<<<<<< HEAD
  delegate :name, to: :client, prefix: true
  delegate :name, to: :person, prefix: true
  delegate :name, :email, :phone, :mobile, :birthday, :full_name, to: :person
=======
  delegate :name, to: :client, prefix: true, allow_nil: true
  delegate :name, :first_name, :last_name, :email, :phone, :mobile, :birthday, to: :person
>>>>>>> 7957982b86bc88da4623f8c99cc17582e9277be1

  validates_associated :person, :client

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

<<<<<<< HEAD
=======
  pg_search_scope :seek_first_name, associated_against: {person: [:first_name]}, using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_last_name, associated_against: {person: [:last_name]}, using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_email, associated_against: {person: [:email]}, using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_client_name,  associated_against: {client: [:name]},using: {tsearch: {prefix: true}}
>>>>>>> 7957982b86bc88da4623f8c99cc17582e9277be1

  pg_search_scope :seek_first_name, associated_against: { person: [:first_name] }, using: { tsearch: { prefix: true }}
  pg_search_scope :seek_last_name, associated_against: { person: [:last_name] }, using: { tsearch: { prefix: true }}
  pg_search_scope :seek_name, associated_against: 
                            { person: [:name] }, using: { tsearch: { prefix: true  } }
  #pg_search_scope :seek_client_name,  associated_against: {client: [:name]},using: {tsearch: {prefix: true}}
  scope :from_client , ->  ( client_id ) { where(client_id: client_id)}

<<<<<<< HEAD
  def self.search_with name, company
    search_name(name)
    #search_client_name(company)
=======
  def self.search_with first_name, last_name, email, company
    search_first_name(first_name).
    search_last_name(last_name).
    search_email(email).
    include_client_name(company)
>>>>>>> 7957982b86bc88da4623f8c99cc17582e9277be1
  end

  def self.search_first_name first_name
    if first_name.present?
      seek_first_name(first_name)
    else
      order("created_at DESC")
    end
  end

  def self.search_last_name last_name
    if last_name.present?
      seek_last_name(last_name)
    else
      order("created_at DESC")
    end
  end

  def self.search_email email
    if email.present?
      seek_email(email)
    else
      order("created_at DESC")
    end
  end

  def self.include_client_name client_name
    if client_name.present?
      Contact.joins("JOIN clients ON clients.id = contacts.client_id").joins("JOIN entities ON entities.id = clients.entity_id").where("entities.name ILIKE '%' || ? || '%'", client_name)
    else
      order("created_at DESC")
    end    
  end

  def slug_candidates
    if person_id.present?
      [
        person.name,
        [person.name, client_name]
      ]
    else
      nil
    end
  end

<<<<<<< HEAD
  def belongs_to_invoice invoice_id
    if invoice_id.present?
      invoice = Invoice.find(invoice_id)
      invoice.contacts.include? self
    end
  end

=======
>>>>>>> 7957982b86bc88da4623f8c99cc17582e9277be1
end