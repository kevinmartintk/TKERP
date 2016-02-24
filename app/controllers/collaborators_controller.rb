class CollaboratorsController < ApplicationController
  add_breadcrumb "Collaborators", :collaborators_path

  before_action :set_collaborator_and_person, only: [:show, :edit, :update]
  before_action :set_collaborator, only: [:destroy]

  respond_to :html

  load_and_authorize_resource

  def index
    @collaborators = Collaborator.search_with(params[:first_name], params[:last_name], params[:birthday_month], params[:start_date])
  end

  def show
  end

  def new
    add_breadcrumb "New Collaborator", :new_collaborator_path
    @person = Person.new
    @person.prepare_collaborator
  end

  def edit
    add_breadcrumb "Editing Collaborator", :edit_collaborator_path
    @person.prepare_collaborator
  end

  def create
    @person = Person.new(collaborator_person_params)

    if @person.save_collaborator
      redirect_to collaborators_path, notice: 'Collaborator was successfully created.'
    else
      render :new
    end
  end

  def update
    @person.assign_attributes(collaborator_person_params)

    if @person.save_collaborator
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

  def update_insurance_types
    insurance = params[:insurance]
    @insurance_types = case insurance
      when "fola" then %w(A B C D E F G)
      when "eps" then %w(base adicional_1 adicional_2)
    end
    respond_to do |format|
      format.js
    end
  end

  private

    def set_collaborator
      @collaborator = Collaborator.find(params[:id])
    end

    def set_collaborator_and_person
      set_collaborator
      @person = @collaborator.person
    end

    def collaborator_person_params
      params.require(:person).permit(:first_name, :last_name, :dni, :dni_scan, :birthday, :email, :civil_status, :gender, :address, :phone, :mobile, :skype, :position_id, collaborator_attributes: [:id, :code, :first_day, :team_id, :work_mail, :type, :status, :salary, :blood_type, :allergies, :disability, :before_employment_test, :around_employment_test, :after_employment_test, :insurance, :insurance_type, spouse_relationship_attributes: [person_attributes: person_params], children_relationships_attributes: [:id, :_destroy, person_attributes: person_params], studies_attributes: [:id, :type, :degree, :start, :end, :_destroy, entity_attributes: study_params], job_experiences_attributes: [:position_id, :type, :start, :end, :achievements, :functions, :certificate, entity_attributes: job_experience_params, reference_attributes: reference_params], collaborator_salary_bank_attributes: bank_params, collaborator_cts_bank_attributes: bank_params, collaborator_pension_entity_attributes: [:entity_id], emergency_relationship_attributes: [:type, person_attributes: emergency_params]])
    end

    def study_params
      [:name, :type, :address, :country_id]
    end

    def job_experience_params
      [:name, :address, :phone, :legal_id, :country_id, :type]
    end

    def person_params
      [:first_name, :last_name, :dni, :birthday, :dni_scan, :certificate]
    end

    def reference_params
      [:first_name, :last_name, :mobile, :email]
    end

    def bank_params
      [:entity_id, :account_number]
    end

    def emergency_params
      [:first_name, :last_name, :dni, :type, :phone, :mobile]
    end
end
