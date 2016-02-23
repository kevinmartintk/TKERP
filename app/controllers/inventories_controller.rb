class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Inventories", :inventories_path
  respond_to :html
  load_and_authorize_resource

  def index
    @inventories = Inventory.search_with(params[:name], params[:description], params[:reg_date], params[:type], params[:team])
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

  def update_collaborators
    @collaborators = Collaborator.team(params[:team_id])
    respond_to do |format|
      format.js
    end
  end

  def update_operating_systems
    scope = case params[:type]
      when "Device" then "mobile"
      when "Computer" then "desktop"
      else "all"
    end
    @operating_systems = OperatingSystem.send(scope)
    respond_to do |format|
      format.js
    end
  end

  private
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    def inventory_params
      params.require(:inventory).permit(:collaborator_id, :name, :brand, :team_id, :inventory_type_id, :edition, :writer, :register_date, :editorial, :model, :description, :quantity, :serie, :image, :operating_system_id, :storage, :hdd, :cpu, :ram, :type)
    end
end