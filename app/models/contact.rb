class Contact < ActiveRecord::Base
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

  searchable do
    text :name
    text :client_name do |contact|
      contact.client_name
    end
  end
end