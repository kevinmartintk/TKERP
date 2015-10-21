class Status

  attr_accessor :id, :name

  TO_ISSUE_ID = 1
  ISSUED_ID = 2
  PAID_ID = 3
  CANCELED_ID = 4
  PARTIAL_PAYMENT_ID = 5

  def initialize(id, name)
  	@id = id
  	@name = name
  end

  def self.all
  	[to_issue,issued,paid,canceled,partial_payment]
  end

  def self.to_issue
  	new(TO_ISSUE_ID, "To issue")
  end

  def self.issued
  	new(ISSUED_ID, "Issued")
  end

  def self.paid
  	new(PAID_ID, "Paid")
  end

  def self.canceled
  	new(CANCELED_ID, "Canceled")
  end

  def self.partial_payment
    new(PARTIAL_PAYMENT_ID, "Partial Payment")
  end

  def self.find id_tmp
  	case id_tmp
      when TO_ISSUE_ID
        to_issue
      when ISSUED_ID
        issued
      when PAID_ID
        paid
      when CANCELED_ID
        canceled
      when PARTIAL_PAYMENT_ID
        partial_payment
    end
  end
end