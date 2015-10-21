class QuotationsController < ApplicationController
  before_action :set_quotation, only: [:show, :edit, :update, :destroy]
  before_action :set_prospect, only: [:index, :new, :create,:show, :edit, :update, :destroy]
  before_action :set_estimations, only: [:show, :edit]

  add_breadcrumb "Prospects", :prospects_path
  add_breadcrumb "Quotations", :prospect_quotations_path

  # GET /quotations
  # GET /quotations.json
  def index
    @quotations = Quotation.where(prospect: @prospect)
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
    add_breadcrumb "Quotation Nº#{@quotation.id} Detail", :prospect_quotation_path
  end

  # GET /quotations/new
  def new
    add_breadcrumb "New Quotation", :new_prospect_quotation_path
    @quotation = Quotation.new
    @quotation.prospect = @prospect
    @estimations = @prospect.estimations
    estimation_size = @estimations.count
    estimation_size.times { @quotation.quotation_estimations.build }
  end

  # GET /quotations/1/edit
  def edit
    add_breadcrumb "Editing Quotation", :edit_prospect_quotation_path
    @total_estimation = @prospect.estimations
    extra_estimations = @total_estimation - @estimations
    @estimations += extra_estimations
    estimation_size = extra_estimations.count
    estimation_size.times { @quotation_estimations.build }
  end

  # POST /quotations
  # POST /quotations.json
  def create
    if @quotation = @prospect.quotations.create(quotation_params)
      unless @quotation.quotation_estimations.empty?
        redirect_to prospect_quotations_path(:prospect_id => @prospect.id), notice: 'Quotation was successfully created.'
      else
        flash[:alert] = "You need to check at least one estimation."
        redirect_to action: "new"
      end
    else
      render :new
    end
  end

  # PATCH/PUT /quotations/1
  # PATCH/PUT /quotations/1.json
  def update
    respond_to do |format|
      if @quotation.update(quotation_params)
        format.html { redirect_to prospect_quotations_path(:prospect_id => @prospect.id), notice: 'Quotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @quotation }
      else
        format.html { render :edit }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to prospect_quotations_path(:prospect_id => @prospect.id), notice: 'Quotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_prospect
      @prospect = Prospect.find(params[:prospect_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_quotation
      @quotation = Quotation.find(params[:id])
      @quotation_estimations = @quotation.quotation_estimations
    end

    def set_estimations
      @estimations = @quotation.estimations
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quotation_params
      quotation_params = params.require(:quotation).permit(:price_per_hour, :total, quotation_estimations_attributes: [:id,:selected, :estimation_id, :quotation_id, :days_est, :hours_est, :price], estimations_attributes: [:id, :technology_id, :days, :hours])
      # remove estimations that weren't selected
      # quotation_params[:quotation_estimations_attributes].delete_if{|k,v| v[:selected] == "0"}
      return quotation_params
    end

end
