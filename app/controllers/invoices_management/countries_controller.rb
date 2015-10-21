module InvoicesManagement
  class CountriesController < ApplicationController
    add_breadcrumb "Countries", :invoices_management_countries_path
    respond_to :html
    load_and_authorize_resource

    def index
      @headquarters_to_invoice = Headquarter.all
    end
  end
end
