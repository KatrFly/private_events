class InvitationsController < ApplicationController
  def index
    @invitations = Invitation.all
  end

  def new
    @event = Event.find(params[:id])
    @invitation = Invitation.new(user_id: current_user.id, event_id: @event_id)
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
    params.require(:invitation).permit(:)

    def event_params
      params.require(:event).permit(:name, :place, :date)
    end
end
