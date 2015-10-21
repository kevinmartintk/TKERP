class Invoice < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :client
  belongs_to :headquarter
  has_attached_file :document, styles: { medium: "400x600>"}
  validates_attachment_file_name :document, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

  has_attached_file :purchase_order, styles: { medium: "400x600>"}
  validates_attachment_file_name :purchase_order, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

  has_attached_file :invoice_pdf
  validates_attachment_content_type :invoice_pdf, content_type: /pdf/

  has_many :invoice_contacts
  has_many :contacts, through: :invoice_contacts

  acts_as_paranoid

  validates :client,:description, :currency, :amount, :status,:invoice_contacts, presence: true

  accepts_nested_attributes_for :invoice_contacts, :allow_destroy => true

  delegate :name, :legal_id, :to => :client, :prefix => true

	# extend FriendlyId
	# friendly_id :name, use: [:slugged, :finders]
  searchable do
    text :client_name do |invoice|
      invoice.client_name
    end
    string :client_legal_id do |invoice|
      invoice.client_legal_id
    end
    integer :headquarter_id do |invoice|
    	invoice.headquarter.id
    end
    date :created_at
    string :invoice_number
    integer :status
  end

  def self.total_amount invoices, currency_id
    amount = invoices.select{|invoice| invoice.currency == currency_id }.sum(&:amount)
    '%.2f' % amount
  end

  def self.total_soles invoices
    self.total_amount(invoices, Currency::SOLES_ID)
  end

  def self.total_dolar invoices
    self.total_amount(invoices, Currency::DOLLAR_ID)
  end

  def amount_decimal
    number_with_precision(amount, :precision => 2) || 0
  end

  def is_issued?
    status == Status::ISSUED_ID
  end

  def is_to_be_issued?
    status == Status::TO_ISSUE_ID
  end

  def invoice_igv
    number_with_precision(amount * headquarter.country.igv.to_f, :precision => 2) || 0
  end

  def invoice_total
    number_with_precision(amount + invoice_igv.to_f, :precision => 2) || 0
  end

  def invoice_drawdown
    has_drawdown  ? number_with_precision(amount * headquarter.country.drawdown, :precision => 2) || 0 : 0
  end

  def invoice_balance
    invoice_total.to_f - invoice_drawdown.to_f
  end


  def generate_pdf
    pdf = InvoicePDF.new(self, headquarter)
    attachment = pdf.render
    attachment
  end

  def generate_pdf_file attachment
    file = StringIO.new(attachment) #mimic a real upload file
    file.class.class_eval { attr_accessor :original_filename, :content_type } #add attr's that paperclip needs
    file.original_filename = "invoice_#{invoice_number}.pdf"
    file.content_type = "application/pdf"
    file
  end
end