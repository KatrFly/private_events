class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events, class_name: "Event", foreign_key: "creator_id"
  has_many :invitations
  has_many :events_invited_to, through: :invitations, source: :event
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event

  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'invitee_id', dependent: :destroy
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'inviter_id', dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def friendships
    @friendships = Friendship.where(user_id: self.id).or(Friendship.where(friend: self.id))
  end

  def friends
    @friendships = self.friendships.joins(:user)
    @friends = @friendships.map { |f| f.friend == self ? f.user : f.friend }
  end

  def friend_request_exists?(user_id)
    @requests = FriendRequest.all

    return nil if @requests.empty?

    @requests.map do |request|
      return request if request.inviter_id == user_id && request.invitee_id == self.id
      return request if request.invitee_id == user_id && request.inviter_id == self.id
      return nil
    end
  end

  def already_attending?(event)
    if self.attended_events.include?(event)
      return Attendance.find_by(event_id: event.id, user_id: self.id)
    else
      nil
    end
  end

  def find_invitation(event)
    invitation = self.invitations.find_by(event_id: event.id)

    return invitation
  end
end
