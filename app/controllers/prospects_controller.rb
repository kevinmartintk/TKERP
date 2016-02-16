class ProspectsController < ApplicationController
  before_action :set_prospect, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Prospects", :prospects_path

  def index
    @prospects = Prospect.search_with(params[:name], params[:client_name], params[:status], params[:prospect_type], params[:country_id], params[:client_type], params[:partner_id])
  end

  def show
    add_breadcrumb "#{@prospect.name}", :prospect_path
  end

  def new
    add_breadcrumb "New Prospect", :new_prospect_path
    @prospect = Prospect.new
  end

  def edit
    add_breadcrumb "Editing Prospect", :edit_prospect_path
  end

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

  def destroy
    @prospect.destroy
    respond_to do |format|
      format.html { redirect_to prospects_url, notice: 'Prospect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_prospect
      @prospect = Prospect.find(params[:id])
    end

    def prospect_params
      params.require(:prospect).permit(:client_id, :country_id, :name, :arrival_date, :contact, :arrival_team_date, :type, :legal_id, :team_id, :status, :observation, :approved_at, :account_id, prospect_contacts_attributes: [:id, :contact_id, :_destroy])
    end
end
