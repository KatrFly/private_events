class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def get_the_users_friend(user)
    return user if friend_id == user.id
    return friend if user_id == user.id
  end
end
