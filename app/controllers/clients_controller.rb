class ClientsController < ApplicationController
  add_breadcrumb "Clients", :clients_path
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  respond_to :html,:json
  load_and_authorize_resource

  # GET /places
  # GET /places.json
  def index
    @clients = Client.search_with(params[:name], params[:legal_id])
  end

  # GET /places/1
  # GET /places/1.json
  def show
    respond_with(@client)
  end

  # GET /places/new
  def new
    add_breadcrumb "New Client", :new_client_path
    @client = Client.new
  end

  # GET /places/1/edit
  def edit
    add_breadcrumb "Editing Client", :edit_client_path
  end

  # POST /places
  # POST /places.json
  def create
    @client = Client.new(client_params)
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

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
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

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    if @client.destroy
      redirect_to clients_path, notice: 'Client was successfully deleted.'
    else
      redirect_to clients_path, alert: "Client couldn't be deleted due to existing Invoices."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name,:address,:country_id,:legal_id, :corporate_name)
    end
end

