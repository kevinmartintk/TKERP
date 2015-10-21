class ScheduleController < ApplicationController
  before_action :set_collaborator
  before_action :set_event, only: [:edit, :update, :delete, :destroy]
  respond_to :html, :js, :json
  add_breadcrumb "Collaborators", :collaborators_path

  def index
    @events = @collaborator.events
  end

  def new
    @event = Event.new
    @url = collaborator_schedule_index_path(@collaborator)
    @method = "POST"
  end

  def create
    @event = Event.new(event_params)
    @event.collaborator = @collaborator
    @success = @event.save
  end

  def edit
    @url = collaborator_schedule_path(@collaborator, @event)
    @method = "PUT"
  end

  def update
    @success = @event.update_attributes(event_params)
  end

  def destroy
    @event.destroy 
  end

  private
    def set_collaborator
      @collaborator = Collaborator.find(params[:collaborator_id])
    end

    def set_event
      @event = Event.find params[:id]
    end

    def event_params
       params.require(:event).permit(:name, :description, :start, :finish,
        :all_day)    
    end
end
