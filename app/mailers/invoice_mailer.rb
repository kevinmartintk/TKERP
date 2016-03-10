class InvoiceMailer < ApplicationMailer
  default from: DEFAULT_MAIL

  def send_invoice contact, invoice, message
    @contact = contact
    @invoice = invoice
    @message = message
    attachments['invoice.pdf'] = {
      content: open(invoice.pdf.path).read
    }
    mail(to: @contact.email, subject: "Invoice" + "N° "+"#{@invoice.invoice_number}")
  end

end
