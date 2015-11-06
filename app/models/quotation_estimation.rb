class QuotationEstimation < ActiveRecord::Base
  # acts_as_paranoid

  belongs_to :quotation
  belongs_to :estimation

  def self.total_days
    self.sum(:developer_days_est)
  end

  def self.total_hours
    self.sum(:developer_hours_est)
  end

end

