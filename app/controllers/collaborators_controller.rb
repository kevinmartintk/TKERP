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
      # study = collaborator.studies.build
      # study.build_entity

    #laboral
      # job_experience = collaborator.job_experiences.build
      # job_experience.build_entity
      # job_experience.build_reference

    #payment
      # collaborator.build_collaborator_salary_bank
      # collaborator.build_collaborator_cts_bank
      # collaborator.build_collaborator_pension_entity

    #emergency
      # emergency_relationship = collaborator.build_emergency_relationship
      # emergency_relationship.build_person

  end

  def edit
    add_breadcrumb "Editing Collaborator", :edit_collaborator_path
  end

  def create
    @person = Person.create(person_params)

    if @person.save
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
      params.require(:person).permit(:first_name, :last_name, :dni, :dni_scan, :birthday, :email, :civil_status, :gender, :address, :phone, :mobile, :skype, collaborator_attributes: [spouse_relationship_attributes: [person_attributes: relation_params], children_relationships_attributes: [person_attributes: relation_params]], studies_attributes: [:type, :degree, :start, :end, entity_attributes: [:name, :type, :address, :country_id]])
    end

    def relation_params
      [:first_name, :last_name, :dni, :birthday]
    end
end
