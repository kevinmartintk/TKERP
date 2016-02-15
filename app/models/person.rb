class Person < ActiveRecord::Base
  acts_as_paranoid

  has_one :contact
  has_one :collaborator
  has_many :relationships
  has_many :collaborators, through: :relationships

  accepts_nested_attributes_for :contact
  accepts_nested_attributes_for :collaborator

  enum civil_status: [:single, :married, :widower, :divorced]
  enum gender: [:male, :female]

  validates :first_name, :last_name, presence: true
  validates_format_of :phone, :mobile, with: /\A(([ \)])[0-9]{1,3}([ \)]))?([\(][0-9]{1,3}[\)])?([0-9 \.\-]{1,9})\Z/, allow_blank: true
  validates_format_of :extension, with: /\A(([ \)])[0-9]{1,3}([ \)]))?([\(][0-9]{1,3}[\)])?([0-9 \.\-]{1,9})\Z/, allow_blank: true

  def name
    "#{first_name} #{last_name}"
  end

end
