class EstimationsController < ApplicationController
  before_action :set_estimation, only: [:show, :edit, :update, :destroy]
  before_action :set_prospect, only: [:index, :new, :create,:show, :edit, :update, :destroy]
  add_breadcrumb "Prospects", :prospects_path
  add_breadcrumb "Estimations", :prospect_estimations_path

  # GET /estimations
  # GET /estimations.json
  def index
    @estimations = @prospect.estimations
  end

  # GET /estimations/1
  # GET /estimations/1.json
  def show
    add_breadcrumb "Estimation Nº#{@estimation.id} Detail", :prospect_estimation_path
  end

  # GET /estimations/new
  def new
    add_breadcrumb "New Estimation", :new_prospect_estimation_path
    @estimation = Estimation.new
    @estimation.prospect = @prospect
  end

  # GET /estimations/1/edit
  def edit
    add_breadcrumb "Editing Estimation", :edit_prospect_estimation_path
  end

  # POST /estimations
  # POST /estimations.json
  def create
    @estimation = Estimation.new(estimation_params)
    @estimation.prospect = @prospect

    respond_to do |format|
      if @estimation.save
        format.html { redirect_to prospect_estimations_path(:prospect_id => @prospect.id), notice: 'Estimation was successfully created.' }
        format.json { render :show, status: :created, location: @estimation }
      else
        format.html { render :new }
        format.json { render json: @estimation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estimations/1
  # PATCH/PUT /estimations/1.json
  def update
    respond_to do |format|
      if @estimation.update(estimation_params)
        format.html { redirect_to prospect_estimations_path(:prospect_id => @prospect.id), notice: 'Estimation was successfully updated.' }
        format.json { render :show, status: :ok, location: @estimation }
      else
        format.html { render :edit }
        format.json { render json: @estimation.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /estimations/1
  # DELETE /estimations/1.json
  def destroy
    @estimation.destroy
    respond_to do |format|
      format.html { redirect_to prospect_estimations_path(:prospect_id => @prospect.id), notice: 'Estimation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private

    def set_prospect
      @prospect = Prospect.find(params[:prospect_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_estimation
      @estimation = Estimation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estimation_params
      params.require(:estimation).permit(:technology_id, :estimation_type, :developers, :status, :developer_days, :developer_hours, :developer_hours_per_day, :designers, :designer_days, :designer_hours, :designer_hours_per_day, :accounts, :account_hours, :sent_at)
    end
end
