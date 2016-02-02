class Entity < ActiveRecord::Base
  self.inheritance_column = nil
  acts_as_paranoid

  has_one :client

  belongs_to :country

  accepts_nested_attributes_for :client

  enum type: [:company, :university, :afp, :institute, :organization, :bank, :ong]

  validates :legal_id, presence: true, length: {is: 11}, uniqueness: true, if: :is_peruvian?
  validates :name, :address, :country, :phone, presence: true
  validates_format_of :phone, :with => /\A(([ \)])[0-9]{1,3}([ \)]))?([\(][0-9]{1,3}[\)])?([0-9 \.\-]{1,9})\Z/

  def is_peruvian?
    country_id.eql?(173)
  end
end
