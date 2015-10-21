class ProspectType

  attr_accessor :id, :name

  FIXED_PRICE_ID = 1
  TIMES_X_MATERIAL_ID = 2

  def initialize(id, name)
  	@id = id
  	@name = name
  end

  def self.all
  	[fixed_price,times_x_material]
  end

  def self.fixed_price
  	new(FIXED_PRICE_ID, "Fixed Price")
  end

  def self.times_x_material
  	new(TIMES_X_MATERIAL_ID, "TimesXMaterial")
  end

  def self.find id_tmp
  	case id_tmp
    	when FIXED_PRICE_ID
    		fixed_price
    	when TIMES_X_MATERIAL_ID
  		  times_x_material
    end
  end
end