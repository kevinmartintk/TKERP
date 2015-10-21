class QuotationEstimation < ActiveRecord::Base
  # acts_as_paranoid

  belongs_to :quotation
  belongs_to :estimation

  def self.total_days
    self.sum(:days_est)
  end

  def self.total_hours
    self.sum(:hours_est)
  end

end

