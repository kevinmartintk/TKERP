class ProspectStatus

  attr_accessor :id, :name

  RECEIVED_ID = 1
  AT_ESTIMATION_ID = 2
  SENT_ID = 3
  ACCEPTED_ID = 4
  CANCELED_ID = 5

  def initialize(id, name)
  	@id = id
  	@name = name
  end

  def self.all
  	[received,at_estimation,sent,accepted,canceled]
  end

  def self.received
  	new(RECEIVED_ID, "Received")
  end

  def self.at_estimation
  	new(AT_ESTIMATION_ID, "At Estimation")
  end

  def self.sent
  	new(SENT_ID, "Sent")
  end

  def self.accepted
  	new(ACCEPTED_ID, "Accepted")
  end

  def self.canceled
  	new(CANCELED_ID, "Canceled")
  end

  def self.find id_tmp
    case id_tmp
    	when RECEIVED_ID
    	  received
    	when AT_ESTIMATION_ID
  		  at_estimation
  		when SENT_ID
  		  sent
  		when ACCEPTED_ID
  		  accepted
  		when CANCELED_ID
  		  canceled
    end
  end
end