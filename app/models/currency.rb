class Currency < ActiveRecord::Base

  has_many :quotations

  def self.currency_symbol name
    find_by(name: name).symbol
  end

end