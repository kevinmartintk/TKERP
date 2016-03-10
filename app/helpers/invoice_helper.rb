module InvoiceHelper
  def content_mailer_to contact=nil
"Estimado #{contact.name if contact} , 

Te enviamos a continuación la factura N° 12345 generada.

Saludos,"
  end
end