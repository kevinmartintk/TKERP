class InvoiceMailer < ApplicationMailer
  default from: "tektonerp@gmail.com"

	def send_invoice contact, invoice, message
	  @contact = contact
	  @invoice = invoice
    @message = message

    attachments['invoice.pdf'] = {
    	content: open(invoice.pdf.path).read
    }
	  mail(to: @contact.email, subject: "Invoice")
	end

end
