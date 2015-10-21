class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Countries", :countries_path
  respond_to :html
  load_and_authorize_resource

  def index
    @countries = Country.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @country = Country.new
  end

  def edit
    p "edit"
  end

  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        format.html { redirect_to countries_path, notice: 'Country was successfully created.' }
        format.json { render :show, status: :created, location: @country }
      else
        format.html { render :new }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to countries_path, notice: 'Country was successfully updated.' }
        format.json { render :show, status: :ok, location: @country }
      else
        format.html { render :edit }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_path, notice: 'Country was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      params.require(:country).permit(:name)
    end
end
