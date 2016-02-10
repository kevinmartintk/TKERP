class Currency < ActiveRecord::Base

  def self.currency_symbol name
    find_by(name: name).symbol
  end

end
