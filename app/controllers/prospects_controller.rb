class ProspectsController < ApplicationController
  before_action :set_prospect, only: [:show, :edit, :update, :destroy]
  autocomplete :client, :name
  add_breadcrumb "Prospects", :prospects_path

  # GET /prospects
  # GET /prospects.json
  def index
    @prospects = Prospect.search_with(params[:name], params[:client_name], params[:status], params[:prospect_type], params[:country_id], params[:client_type], params[:partner_id])
  end

  # GET /prospects/1
  # GET /prospects/1.json
  def show
    add_breadcrumb "#{@prospect.name}", :prospect_path
  end

  # GET /prospects/new
  def new
    add_breadcrumb "New Prospect", :new_prospect_path
    @prospect = Prospect.new
  end

  # GET /prospects/1/edit
  def edit
    add_breadcrumb "Editing Prospect", :edit_prospect_path
  end

  # POST /prospects
  # POST /prospects.json
  def create
    begin
      @prospect = Prospect.new(prospect_params)
      if @prospect.save
        redirect_to prospects_path, notice: 'Prospect was successfully created.'
      else
        render :new
      end
    rescue
      render :new
    end
  end

  # PATCH/PUT /prospects/1
  # PATCH/PUT /prospects/1.json
  def update
    begin
      if @prospect.update(prospect_params)
        redirect_to prospects_path, notice: 'Prospect was successfully updated.'
      else
        render :edit
      end
    rescue
      render :edit
    end
  end

  # DELETE /prospects/1
  # DELETE /prospects/1.json
  def destroy
    @prospect.destroy
    respond_to do |format|
      format.html { redirect_to prospects_url, notice: 'Prospect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prospect
      @prospect = Prospect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prospect_params
      params.require(:prospect).permit(:client_id,:country_id,:name,:arrival_date, :contact, :arrival_team_date,:prospect_type,:legal_id,:team,:status,:observation,:approved_at, :account_id, prospect_contacts_attributes: [:id, :contact_id, :_destroy])
    end
end
