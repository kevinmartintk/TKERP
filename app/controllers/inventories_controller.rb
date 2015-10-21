class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Inventories", :inventories_path
  respond_to :html
  load_and_authorize_resource

  def index
    search = Inventory.search do |s|
      if params[:code_or_name].present?
        s.any_of do |a|
          a.with :code, params[:code_or_name]
          a.with :name, params[:code_or_name]
        end
      end
      s.with :inventory_type_id, params[:inventory_type_id] if params[:inventory_type_id].present?
      s.with :team, params[:team] if params[:team].present?
      s.fulltext params[:description] do
        fields(:description)
      end
      s.with(:reg_date).equal_to(params[:reg_date].to_date) if params[:reg_date].present?
    end
    @inventories = search.results
  end

  def show
  end

  def new
    add_breadcrumb "New Inventory", :new_inventory_path
    @inventory = Inventory.new
  end

  def edit
    add_breadcrumb "Editing Inventory", :edit_inventory_path
  end

  def create
    begin
      @inventory = Inventory.new(inventory_params)
      if @inventory.save
        redirect_to inventories_path, notice: 'Inventory was successfully created.'
      else
        render :new
      end
    rescue
      render :new
    end
  end

  def update
    begin
      if @inventory.update(inventory_params)
        redirect_to inventories_path, notice: 'Inventory was successfully updated.'
      else
        render :edit
      end
    rescue
      render :edit
    end
  end

  def destroy
    begin
      if @inventory.destroy
        redirect_to inventories_path, notice: 'Inventory was successfully destroyed.'
      end
    rescue
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_params
      params.require(:inventory).permit(:name, :brand, :team, :inventory_type_id, :edition, :writer, :reg_date,:editorial, :model, :description, :copies, :serie, :image)
    end
end

