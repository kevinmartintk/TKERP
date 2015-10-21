class InvoiceMailer < ApplicationMailer
  default from: "tektonerp@gmail.com"

	def send_invoice(contact,invoice,message)
	  @contact = contact
	  @invoice = invoice
    @message = message
    attachments[@invoice.invoice_pdf_file_name] = File.read(@invoice.invoice_pdf.path)
	  mail(to: @contact.email, subject: "Invoice")
	end

end
