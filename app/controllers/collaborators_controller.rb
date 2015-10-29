class CollaboratorsController < ApplicationController
  before_action :set_collaborator, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Collaborators", :collaborators_path
  respond_to :html
  load_and_authorize_resource

  def index
    @collaborators = Collaborator.search_with(params[:name], params[:last_name], params[:birthday_month], params[:start_date])
  end

  def show
  end

  def new
    add_breadcrumb "New Collaborator", :new_collaborator_path
    @collaborator = Collaborator.new
    #@schedule = @collaborator.schedules.build
  end

  def edit
    add_breadcrumb "Editing Collaborator", :edit_collaborator_path
  end

  def create
    begin
      @collaborator = Collaborator.new(collaborator_params)
      if @collaborator.save
        redirect_to collaborators_path, notice: 'Collaborator was successfully created.'
      else
        render :new
      end
    rescue
      render :new
    end
  end

  def update
    begin
      if @collaborator.update(collaborator_params)
        redirect_to collaborators_path, notice: 'Collaborator was successfully updated.'
      else
        render :edit
      end
    rescue
      render :edit
    end
  end

  def destroy
    begin
      if @collaborator.destroy
        redirect_to collaborators_path, notice: 'Collaborator was successfully destroyed.'
      end
    rescue
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaborator
      @collaborator = Collaborator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collaborator_params
      params.require(:collaborator).permit(:name, :last_name, :dni, :calendar, :birthday, :mail, :currency, :relationship, :mobile, :skype, :em_number, :contact, :address, :start_day, :salary, :team)
    end

end
