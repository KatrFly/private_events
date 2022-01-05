class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :invitations
  has_many :attendees, trough: :invitations, source: :attendee
end
