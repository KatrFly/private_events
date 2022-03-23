class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :invitations
  has_many :attendees, through: :invitations, source: :user

  scope :past, -> { where("date < ?", Date.current) }
  scope :future, -> { where("date >= ?", Date.current) }

  enum visibility: { only_invited: "only_invited", only_friends: "only_friends" , public_event: "public_event" }
end
