class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events, class_name: "Event", foreign_key: "creator_id"
  has_many :invitations
  has_many :attended_events, through: :invitations, source: :event

  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'invitee_id', dependent: :destroy
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'inviter_id', dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def friends_include_user?(current_user, friend_id)
    friend_ids = []

    current_user.all_friends.each do |f|
      friend_ids << f.id
    end
    return true if friend_ids.include?(friend_id) 
  end

  def friend_request_send?(user_id, current_user)
    @requests = FriendRequest.all 

    @requests.map do |request|
      return true if request.inviter_id == user_id && request.invitee_id == current_user.id
      return true if request.invitee_id == user_id && request.inviter_id == current_user.id
      return false
    end
  end 
end
