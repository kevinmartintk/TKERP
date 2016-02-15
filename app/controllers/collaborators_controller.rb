class CollaboratorsController < ApplicationController
  add_breadcrumb "Collaborators", :collaborators_path

  before_action :set_collaborator_and_person, only: [:show, :edit, :update]
  before_action :set_collaborator, only: [:destroy]

  respond_to :html

  load_and_authorize_resource

  def index
    @collaborators = Collaborator.search_with(params[:name], params[:last_name], params[:birthday_month], params[:start_date])
  end

  def show
  end

  def new
    add_breadcrumb "New Collaborator", :new_collaborator_path

    #general #internal #health
      @person = Person.new
      collaborator = @person.build_collaborator

    #familiar
      spouse_relationship = collaborator.build_spouse_relationship
      spouse_relationship.build_person
      children_relationship = collaborator.children_relationships.build
      children_relationship.build_person

    #academic
      study = collaborator.studies.build
      study.build_entity

    #laboral
      job_experience = collaborator.job_experiences.build
      job_experience.build_entity
      job_experience.build_reference

    #payment
      collaborator.build_collaborator_salary_bank
      collaborator.build_collaborator_cts_bank
      collaborator.build_collaborator_pension_entity

    #emergency
      emergency_relationship = collaborator.build_emergency_relationship
      emergency_relationship.build_person

  end

  def edit
    add_breadcrumb "Editing Collaborator", :edit_collaborator_path
  end

  def create
    @person = Person.create(person_params)
    @collaborator = Collaborator.new(collaborator_params)

    if @collaborator.save
      redirect_to collaborators_path, notice: 'Collaborator was successfully created.'
    else
      render :new
    end
  end

  def update
    @person.update_attributes(person_params)
    @collaborator.assign_attributes(collaborator_params)

    if @collaborator.update(collaborator_params)
      redirect_to collaborators_path, notice: 'Collaborator was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @collaborator.destroy
      redirect_to collaborators_path, notice: 'Collaborator was successfully destroyed.'
    end
  end

  private

    def set_collaborator
      @collaborator = Collaborator.find(params[:id])
    end

    def set_collaborator_and_person
      set_collaborator
      @person = @contact.person
    end

    def person_params
      p "PERSON"
      params.require(:person).permit(:first_name, :last_name, :dni, :birthday, :email, :civil_status, :gender, :address, :skype, :phone, :mobile, :position_id, :has_family, :has_partner, :has_children)
    end

    def collaborator_params
      p "COLLABORATOR"
      params.require(:person).permit(collaborator_attributes: [:code, :first_day, :team_id, :work_mail, :type, :status, :salary, :blood_type, :allergies, :disability, :insurance, :insurance_type, spouse_relationship: [spouse: [:first_name, :last_name, :dni, :birthday]], children_relationships_attributes: [:id, children: [:first_name, :last_name, :dni, :birthday]], studies_attributes: [:id, :type, :degree, :start, :end, entity: [:name, :type, :address, :country_id]], job_experiences_attributes: [:id, :position_id, :type, :start, :end, :achievements, :functions, entity_attributes:[:name, :address, :phone, :legal_id, :country_id, :type], reference_attributes: [:first_name, :last_name, :mobile, :email]], collaborator_salary_bank: [:entity_id, :account_number], collaborator_cts_bank: [:entity_id, :account_number], collaborator_pension_entity: [:entity_id], emergency_relationship: [emergency_contact: [:first_name, :last_name, :dni, :birthday]]])
    end
end
