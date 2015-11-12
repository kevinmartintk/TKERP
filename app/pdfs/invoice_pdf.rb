class InvoicePDF < Prawn::Document

  def initialize invoice, headquarter
    super()
    @invoice = invoice
    @headquarter = headquarter
    header
    text_basic_information
    table_presentation
    text_content
    table_content
    footer_content
  end
 
  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/Tekton_logo.jpg", width: 210, height: 50
    # text_box "Invoice ##{ @invoice.invoice_number }", align: :right, size: 15, style: :bold
  end

  def text_basic_information
    y_position = cursor - 100
    I18n.locale = :es
    bounding_box([0, y_position + 100 ], :width => 270, :height => 150) do
      text "Av. Paseo de la República N° 3147", size: 11
      text "Oficina 702", size: 11
      text "San Isidro - Lima - Lima", size: 11
      text "Telf. 422 10 39", size: 11
      text "Web: www.tektonlabs.com", size: 11
      text " "
      day = "#{@invoice.created_at.strftime("%d de ")}"
      month = "#{@invoice.created_at.strftime("%B")}".downcase
      year = "#{@invoice.created_at.strftime(" del %Y")}"
      text "Lima, " + day + I18n.t(month) + year, size: 12
    end    
  end
 
  def text_content
    y_position = cursor + 200
    bounding_box([0, y_position], :width => 270, :height => 150) do
      text " "
      text "Señor(es):", size: 11, style: :bold
      text "Dirección:", size: 11, style: :bold
      text "R.U.C. N°:", size: 11, style: :bold
    end 
    bounding_box([70, y_position ], :width => 270, :height => 150) do
      text " "
      text "#{ @invoice.client.name }", size: 11
      text "#{ @invoice.client.address }", size: 11
      text "#{ @invoice.client.legal_id }", size: 11
    end 
  end  

  def table_presentation
    y_position = cursor + 140
    bounding_box([250, y_position], :width => 270, :height => 300) do
      table presentation_rows do
        row(1).font_style = :bold
        self.row_colors = ['FFFFFF', '2970E8']
        self.column_widths = [250, 250]
        self.position = :right
        self.cell_style = { size: 12, align: :center }
      end
    end
  end
 
  def table_content
    y_position = cursor + 80
    bounding_box([0, y_position], :width => 520, :height => 200) do
      table product_rows do
        row(0).font_style = :bold
        self.row_colors = ['D2E3ED', 'FFFFFF']
        self.column_widths = [420, 100]
        self.position = :center
        self.cell_style = { size: 12 }
      end
    end
  end

  def footer_content
    if @invoice.has_drawdown?
      bounding_box([0, 350], :width => 180, :height => 100) do
        text "---------------------------------------", size: 10, align: :center
        text "Cuenta de Detracciones", size: 10, style: :bold, align: :center
        text "00-068-109124", size: 10, align: :center
        text "Banco de la Nación", size: 10, align: :center
        text "TEKTON LABS SAC", size: 10, style: :bold, align: :center
        text "---------------------------------------", size: 10, align: :center
      end
    end

    bounding_box([320, 350], :width => 180, :height => 80) do
      text "Sub Total", size: 13, style: :bold
      if @headquarter.country.id == 173
        text "IGV", size: 13, style: :bold
      end
      text " "
      text " "
      text "TOTAL", size: 13, style: :bold
    end

    bounding_box([425, 350], :width => 270, :height => 80) do
      text "#{ @invoice.amount_decimal }", size: 13
      if @headquarter.country.id == 173
        text "#{ @invoice.invoice_igv }", size: 13
      end
      text "_____________", size: 13
      text " "
      text "#{ @invoice.invoice_total }", size: 13
    end
  end
 
  def presentation_rows
    [["R.U.C. N° 20518538064"], ["F A C T U R A"], [" 001 - N° #{@invoice.invoice_number}"]]
  end

  def product_rows
    [["Descripción", "Total"], ["#{ @invoice.description }", "#{ @invoice.amount_decimal }"]]
  end

end