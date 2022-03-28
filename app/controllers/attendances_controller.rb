class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new(user_id:current_user.id, event_id:@event.id)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to event_url(@event), notice: "Attendance was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end
end