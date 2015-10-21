class InvoicePDF < Prawn::Document

  def initialize invoice, headquarter
    super()
    @invoice = invoice
    @headquarter = headquarter
    header
    text_content
    table_content
    footer_content
  end
 
  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/Tekton_logo.png", width: 210, height: 30
    text_box "Invoice ##{ @invoice.invoice_number }", align: :right, size: 15, style: :bold
  end
 
  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 100
 
    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 270, :height => 150) do
      text "Date", size: 15, style: :bold
      text "Company Name", size: 15, style: :bold
      text "Company Address", size: 15, style: :bold
      text "Company Nro Legal ID", size: 15, style: :bold
    end
 
    bounding_box([180, y_position], :width => 270, :height => 150) do
      text "#{ @invoice.created_at.to_date }", size: 15
      text "#{ @invoice.client.name }", size: 15
      text "#{ @invoice.client.address }", size: 15
      text "#{ @invoice.client.legal_id }", size: 15
    end
 
  end
 
  def table_content
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
    table product_rows do
      row(0).font_style = :bold
      # self.header = true
      self.row_colors = ['D2E3ED', 'FFFFFF']
      self.column_widths = [300, 200]
      self.position = :center
      self.cell_style = { size: 12 }
    end
  end

  def footer_content
    bounding_box([220, 350], :width => 180, :height => 80) do
      text "Sub Total", size: 13, style: :bold
      if @headquarter.country.id == 173
        text "IGV", size: 13, style: :bold
      end
      text " "
      text " "
      text "Invoice Total", size: 13, style: :bold
    end

    bounding_box([325, 350], :width => 270, :height => 80) do
      text "#{ @invoice.amount_decimal }", size: 13
      if @headquarter.country.id == 173
        text "#{ @invoice.invoice_igv }", size: 13
      end
      text "_____________________", size: 13
      text " "
      text "#{ @invoice.invoice_total }", size: 13
    end
  end
 
  def product_rows
    [["Description", "Amount"], ["#{ @invoice.description }", "#{ @invoice.amount_decimal }"]]
  end
end