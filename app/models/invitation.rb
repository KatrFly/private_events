class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum invitation_status: { open: "open", accepted: "accepted", declined: "declined" }
end
