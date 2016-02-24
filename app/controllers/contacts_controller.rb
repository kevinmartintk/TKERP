class ContactsController < ApplicationController
  add_breadcrumb "Contacts", :contacts_path

  before_action :set_contact_and_person, only: [:show, :edit, :update]
  before_action :set_contact, only: [:destroy]

  respond_to :html

  load_and_authorize_resource

  def index
    @contacts = Contact.search_with(params[:first_name], params[:last_name], params[:email], params[:client_name])
  end

  def show
  end

  def new
    add_breadcrumb "New Contact", :new_contact_path
    @person = Person.new
    @person.prepare_contact
  end

  def edit
    add_breadcrumb "Editing Contact", :edit_contact_path
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save_contact
        format.html { redirect_to contacts_path, notice: 'Contact was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @person.assign_attributes(person_params)

    respond_to do |format|
      if @person.save_contact
        format.html { redirect_to contacts_path, notice: 'Contact was successfully updated.' }
      else
        format.html { render :edit }
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
      params.require(:person).permit(:id, :first_name, :last_name, :email, :phone, :extension, :mobile, :birthday, :position_id, :skype, contact_attributes: [:id, :client_id])
    end

end
