class ClientsController < ApplicationController
  add_breadcrumb "Clients", :clients_path

  before_action :set_client_and_entity, only: [:show, :edit, :update]
  before_action :set_client, only: [:destroy]

  respond_to :html,:json

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
    @entity.build_client
  end

  def edit
    add_breadcrumb "Editing Client", :edit_client_path
  end

  def create
    entity = Entity.create(entity_params)
    @client = entity.build_client(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @entity.update_attributes(entity_params)
    @client.assign_attributes(client_params)

    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_path, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
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
      params.require(:entity).permit(:name, :corporate_name, :address, :phone, :legal_id, :country_id, :type)
    end

    def client_params
      params[:entity].require(:client_attributes).permit(:partner_id)
    end
end
