class ContactsController < ApplicationController
  autocomplete :client, :name
  add_breadcrumb "Contacts", :contacts_path
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  respond_to :html
  load_and_authorize_resource

  # GET /places
  # GET /places.json
  def index
    @contacts = Contact.search_with(params[:name], params[:client_name])
  end

  # GET /places/1
  # GET /places/1.json
  def show
  end

  # GET /places/new
  def new
    add_breadcrumb "New Contact", :new_contact_path
    @contact = Contact.new

  end

  # GET /places/1/edit
  def edit
    add_breadcrumb "Editing Contact", :edit_contact_path
  end

  # POST /places
  # POST /places.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contacts_path, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contacts_path, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_path, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name,:email,:phone,:mobile,:birthday,:client_id, :extension, :position)
    end
end