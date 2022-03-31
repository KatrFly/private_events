class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def get_the_users_friend(current_user)
    return user if friend_id == current_user.id
    return friend if user_id == current_user.id
  end
end
