class InvitationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @invitations = Invitation.all
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @invitation = Invitation.new(user_id:current_user.id, event_id:@event.id)
    # @invitation = current_user.created_events.build(event_params)

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to event_url(@event), notice: "Invitation was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:event_id)
  end
end
