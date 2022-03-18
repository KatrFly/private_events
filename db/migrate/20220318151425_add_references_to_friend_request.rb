class AddReferencesToFriendRequest < ActiveRecord::Migration[6.1]
  def change
    add_reference :friend_requests, :inviter
    add_reference :friend_requests, :invitee
  end
end
