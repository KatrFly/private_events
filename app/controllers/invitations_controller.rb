class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @invitations = current_user.invitations
  end

  def new
    @invitation = Invitation.new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(invitation_params[:event_id])
    succes = true

    invitation_params[:invited_users_ids].each do |user_id|
      if !Invitation.find_or_create_by(user_id: user_id.to_i, event_id: @event.id)
        succes = false
      end
    end

    respond_to do |format|
      if succes == true
        format.html { redirect_to event_url(@event), notice: "Invitations were successfully created." }
        format.json { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @invitation = current_user.invitations.find(params[:id])
    @invitation.update(params.require(:invitation).permit(:invitation_status))
    redirect_to invitations_path
  end

  def destroy
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:event_id, invited_users_ids: [])
  end
end
