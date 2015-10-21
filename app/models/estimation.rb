class Estimation < ActiveRecord::Base
  belongs_to :prospect
  belongs_to :technology
  has_many :quotation_estimations
  has_many :quotations, through: :quotation_estimations

  accepts_nested_attributes_for :quotation_estimations, :allow_destroy => true
end
