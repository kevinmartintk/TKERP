class Estimation < ActiveRecord::Base
  belongs_to :prospect
  belongs_to :technology
  has_many :quotation_estimations
  has_many :quotations, through: :quotation_estimations

  accepts_nested_attributes_for :quotation_estimations, :allow_destroy => true

  validate :validate_sent_at

  def validate_sent_at
   if sent_at > Date.today
    self.errors.add(:base, "The fundamental laws of nature prevent time travel")
   end
  end

  def has group
    ( send(group).nil? or send(group) <= 0 ) ? false : true
  end

end
