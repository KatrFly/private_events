class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum invitation_status: { open: "open", accepted: "accepted", declined: "declined" }, _default: "open"

  after_update :create_or_delete_attendance_if_necessary

  def create_or_delete_attendance_if_necessary

  end
end
