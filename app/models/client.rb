class Client < ActiveRecord::Base
  acts_as_paranoid
  belongs_to	:country
  has_many :contacts
  has_many :prospects
  has_many :invoices, :dependent => :restrict_with_error
  validates :name, :country, :address, presence: true

  validates :legal_id, presence: true, if: :is_peruvian?
  validates :legal_id , length: {is: 11}, uniqueness:true, if: :is_peruvian?

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def is_peruvian?
    country_id.eql?(173)
  end

	searchable do
    text :name
    string :legal_id
	end
end