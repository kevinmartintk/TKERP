class ContactsController < ApplicationController
  add_breadcrumb "Contacts", :contacts_path

  before_action :set_contact_and_person, only: [:show, :edit, :update]
  before_action :set_contact, only: [:destroy]

  respond_to :html

  load_and_authorize_resource

  def index
    @contacts = Contact.search_with(params[:name], params[:client_name])
  end

  def show
  end

  def new
    add_breadcrumb "New Contact", :new_contact_path
    @person = Person.new
    @person.build_contact
  end

  def edit
    add_breadcrumb "Editing Contact", :edit_contact_path
  end

  def create
    @person = Person.create(person_params)
    @person.contact.save if @person.valid?

    respond_to do |format|
      if @person.save
        format.html { redirect_to contacts_path, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @person.update_attributes(person_params)
    @contact.assign_attributes(contact_params)

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

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_path, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def set_contact_and_person
      set_contact
      @person = @contact.person
    end

    def person_params
      params.require(:person).permit(:id, :first_name, :last_name, :email, :phone, :extension, :mobile, :birthday, :position_id, contact_attributes: [:client_id])
    end
end
