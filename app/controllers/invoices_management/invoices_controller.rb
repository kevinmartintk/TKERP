module InvoicesManagement
  class InvoicesController < ApplicationController
    before_action :set_headquarter, only: [:index, :new, :create,:show, :edit, :update, :destroy]
    before_action :set_invoice, only: [:show, :edit, :update, :destroy,:send_mail]
    add_breadcrumb "Countries", :invoices_management_countries_path
    add_breadcrumb "Invoices", :invoices_management_country_invoices_path

    respond_to :html

    load_and_authorize_resource

    autocomplete :client, :name

    def index
      @invoices = @headquarter.invoices.search_with(params[:client], params[:legal_id], params[:invoice_number], params[:from_date], params[:to_date], params[:status])
      @total_invoices_soles = "#{Currency.get_symbol_sol} #{Invoice.total_soles(@invoices)}"
      @total_invoices_dollar = "#{Currency.get_symbol_dolar} #{Invoice.total_dolar(@invoices)}"
    end

    def send_mail
      contact = Contact.find(params[:contact])
      message = params[:message]
      InvoiceMailer.send_invoice(contact,@invoice,message).deliver_now
    end

    def show
      respond_to do |format|
        format.pdf do
          attachment = @invoice.generate_pdf
          @invoice.invoice_pdf = @invoice.generate_pdf_file(attachment)
          @invoice.save!
          send_data attachment, filename: 'invoice.pdf', type: 'application/pdf', disposition: "inline"
        end
      end
    end

    def new
      add_breadcrumb "New Invoice", :new_invoices_management_country_invoice_path
      @invoice = Invoice.new
      @invoice.headquarter = @headquarter
    end

    def edit
      add_breadcrumb "Editing Invoice", :edit_invoices_management_country_invoice_path
    end

    def create
      begin
        invoice_detail = Invoice.new(invoice_params)
        invoice_detail.headquarter = @headquarter
        invoice_detail.currency = 2 if @headquarter.country.id != 173

        if invoice_detail.save
          attachment = invoice_detail.generate_pdf
          @invoice = invoice_detail
          @invoice.invoice_pdf = @invoice.generate_pdf_file(attachment)

          redirect_to invoices_management_country_invoices_path(@headquarter.country), notice: 'Invoice was successfully created.'
        else
          render :new
        end
      rescue
        render :new
      end
    end

    def update
      begin
        @invoice.invoice_contacts.delete_all
        if @invoice.update(invoice_params)
          attachment = @invoice.generate_pdf
          @invoice.invoice_pdf = @invoice.generate_pdf_file(attachment)
          @invoice.save!

          redirect_to invoices_management_country_invoices_path, notice: 'Invoice was successfully updated.'
        else
          render :edit
        end
      rescue
        render :edit
      end
    end

    def destroy
      begin
        if @invoice.destroy
          redirect_to invoices_management_country_invoices_path, notice: 'Invoice was successfully destroyed.'
        end
      rescue
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_headquarter
        @headquarter = Headquarter.joins(:country).find_by('countries.slug' => params[:country_id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_invoice
        @invoice = Invoice.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def invoice_params
        params.require(:invoice).permit(:client_id, :description, :currency, :amount, :status, :has_drawdown, :document, :purchase_order, :extra, :contact, :message,:invoice_number, invoice_contacts_attributes: [:contact_id, :_destroy])
      end

  end

end