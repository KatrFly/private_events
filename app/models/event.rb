class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :invitations
  has_many :attendees, through: :invitations, source: :user

  scope :past, -> { where("date < ?", Date.current) }
  scope :future, -> { where("date >= ?", Date.current) }
end
