class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum invitation_status: { open: "open", accepted: "accepted", declined: "declined" }, _default: "open"

  after_update :create_or_delete_attendance_if_necessary

  def create_or_delete_attendance_if_necessary
    if invitation_status == "accepted"
      Attendance.create(user: self.user, event: self.event)
    elsif invitation_status == "declined"
      if attendance = Attendance.find_by(user: self.user, event: self.event)
        attendance.destroy
      end
    end
  end
end
