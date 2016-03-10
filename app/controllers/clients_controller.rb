class ClientsController < ApplicationController
  add_breadcrumb "Clients", :clients_path

  before_action :set_client_and_entity, only: [:show, :edit, :update]
  before_action :set_client, only: [:destroy]

  respond_to :html

  load_and_authorize_resource

  def index
    @clients = Client.search_with(params[:name], params[:legal_id], params[:type], params[:partner_id])
  end

  def show
    respond_with(@client)
  end

  def new
    add_breadcrumb "New Client", :new_client_path
    @entity = Entity.new
    @entity.prepare_client
  end

  def edit
    add_breadcrumb "Editing Client", :edit_client_path
  end

  def create
    @entity = Entity.new(entity_params)

    if @entity.save_client
      redirect_to clients_path, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def update
    @entity.assign_attributes(entity_params)

    respond_to do |format|
      if @entity.save_client
        format.html { redirect_to clients_path, notice: 'Client was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @client.destroy
      redirect_to clients_path, notice: 'Client was successfully deleted.'
    else
      redirect_to clients_path, alert: "Client couldn't be deleted due to existing Invoices."
    end
  end

  private

    def set_client
      @client = Client.find(params[:id])
    end

    def set_client_and_entity
      set_client
      @entity = @client.entity
    end

    def entity_params
      params.require(:entity).permit(:id, :name, :corporate_name, :address, :phone, :legal_id, :country_id, :type, client_attributes: [:id, :partner_id, :type])
    end

end
