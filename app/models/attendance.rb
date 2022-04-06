class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validate :only_allowed_people_can_attend
  validate :must_be_unique

  def must_be_unique
    if attendance = Attendance.find_by(user: self.user, event: self.event)
      errors.add(:user, "You are already attending this event")
    end
  end

  def only_allowed_people_can_attend
    if event.only_friends?
      return if event.creator.friends.include?(user)
      errors.add(:user, "We're sorry but this is an exclusive event and you are not authorized to attend it")
    elsif event.only_invited?
      return if event.invited_guests.include?(user)
      errors.add(:user, "We're sorry but this is an exclusive event and you are not authorized to attend it")
    end
  end
end
