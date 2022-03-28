class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ show, index ]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  def created
    @created_events = Event.where(creator_id: current_user.id)
  end

  def attending
    @attending_events = Event.find_by_sql("SELECT * FROM events JOIN invitations ON event_id = events.id WHERE user_id = #{current_user.id}")
  end

  # GET /events/1 or /events/1.json
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @event = current_user.created_events.build
    @visibility_options = [ ["Only invited persons", 1], ["Only friends", 2], ["Public event", 3] ]
  end

  # GET /events/1/edit
  def edit
    @visibility_options = [ ["Only invited persons", 1], ["Only friends", 2], ["Public event", 3] ]
  end

  # POST /events or /events.json
  def create
    @event = current_user.created_events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :place, :date, :visibility)
    end
end
