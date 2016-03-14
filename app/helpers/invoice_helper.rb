module InvoiceHelper
  def body_mailer_to contact=nil
	"Te enviamos a continuación la factura generada N°"
  end

  def title_mailer_to
  	" Estimado "
  end

  def finish
  	"Saludos."
  end
end