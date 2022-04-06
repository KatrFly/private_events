class FriendRequest < ApplicationRecord
  belongs_to :inviter, class_name: "User"
  belongs_to :invitee, class_name: "User"

  validate :no_friends_yet

  def no_friends_yet
    errors.add(:inviter, "A friend request already exists between these two users") if inviter.friend_request_exists?(invitee.id)
    errors.add(:inviter, "You are already friends") if inviter.friends.include?(invitee)
  end
end
