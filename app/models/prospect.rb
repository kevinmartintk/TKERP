class Prospect < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
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

    searchable do
      text :name
      text :client_name do |prospect|
        prospect.client_name
      end
      integer :country_id do |prospect|
        prospect.client_country_id
      end
      integer :prospect_type
      integer :status
    end

end
