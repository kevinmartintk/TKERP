class Contact < ActiveRecord::Base
  include PgSearch
  acts_as_paranoid

  belongs_to	:client
  has_many :invoice_contacts
  has_many :prospect_contacts
  has_many :invoices, through: :invoice_contacts
  has_many :prospects, through: :prospect_contacts
  has_many :prospects
  validates_format_of :phone, :with => /\A(([ \)])[0-9]{1,3}([ \)]))?([\(][0-9]{1,3}[\)])?([0-9 \.\-]{1,9})\Z/
  validates_format_of :mobile, :with => /\A([\+][0-9]{1,3}([ \.\-])?)?([\(][0-9]{1,6}[\)])?([0-9 \.\-]{1,11})\Z/
  validates :name, :email, :client, presence: true
  delegate :name, :to => :client, :prefix => true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_client_name,  associated_against: {
                           client: [:name]},
                         using: { tsearch: { prefix: true  } }

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
  
end