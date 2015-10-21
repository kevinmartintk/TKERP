class EstimationType

  attr_accessor :id, :name

  DETAILED_ID = 1
  ROUGH_ID = 2

  def initialize(id, name)
  	@id = id
  	@name = name
  end

  def self.all
  	[detailed,rough]
  end

  def self.detailed
  	new(DETAILED_ID, "Detailed")
  end

  def self.rough
  	new(ROUGH_ID, "Rough")
  end

  def self.find id_tmp
  	case id_tmp
    	when DETAILED_ID
    		detailed
    	when ROUGH_ID
  		  rough
    end
  end
end