class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Inventories", :inventories_path
  respond_to :html
  load_and_authorize_resource

  def index
    @inventories = Inventory.search_with(params[:name], params[:description], params[:reg_date], params[:inventory_type_id], params[:team])
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
      params.require(:inventory).permit(:collaborator_id, :name, :brand, :team, :inventory_type_id, :edition, :writer, :reg_date,:editorial, :model, :description, :copies, :serie, :image)
    end
end

