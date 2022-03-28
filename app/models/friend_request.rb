class FriendRequest < ApplicationRecord
  belongs_to :inviter, class_name: "User"
  belongs_to :invitee, class_name: "User"

  validate :no_friends_yet

  def no_friends_yet
    errors.add(:invitee, "you are already friends") if inviter.friends.include?(invitee) || inviter.friend_request_send?(invitee.id)
  end
end
