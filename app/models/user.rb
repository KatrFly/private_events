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

  def friends
    @friendships = Friendship.joins(:user)

    # this gathers all friends by combining the ones where the current_user is in the user-column and the friend is in the friend-column and visa versa.
    @friendships.map { |f| f.friend == self ? f.user : f.friend }
  end

  def friend_request_send?(user_id, current_user)
    @requests = FriendRequest.all 

    return nil if @requests.empty?

    @requests.map do |request|
      return request if request.inviter_id == user_id && request.invitee_id == current_user.id
      return request if request.invitee_id == user_id && request.inviter_id == current_user.id
      return nil
    end
  end 
end
