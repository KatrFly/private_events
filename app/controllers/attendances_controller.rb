class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new(user_id:current_user.id, event_id:@event.id)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to events_url, notice: "Attendance was successfully created." }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { redirect_to events_url, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @event = @attendance.event
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "You succesfully unattended the event." }
      format.json { head :no_content }
    end
  end
end