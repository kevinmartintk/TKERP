class Currency
  attr_accessor :id, :name, :symbol

  SOLES_ID = 1
  DOLLAR_ID = 2

  def initialize(id, name, symbol)
    @id = id
    @name = name
    @symbol = symbol
  end

  def self.all
    [soles, dollar]
  end

  def self.soles
    new(SOLES_ID, "Soles", "S/.")
  end

  def self.dollar
    new(DOLLAR_ID, "Dollar", "$")
  end

  def self.find id_tmp
    case id_tmp
      when SOLES_ID then soles
      when DOLLAR_ID then dollar
    end
  end

  def self.get_symbol currency_id
    Currency.find(currency_id).symbol
  end

  def self.get_symbol_sol
    self.get_symbol(SOLES_ID)
  end

  def self.get_symbol_dolar
    self.get_symbol(DOLLAR_ID)
  end

end
