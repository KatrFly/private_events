class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :invitations
  has_many :invited_guests, through: :invitations, source: :user
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  scope :past, -> { where("date < ?", Date.current) }
  scope :future, -> { where("date >= ?", Date.current) }

  enum visibility: { only_invited: "only_invited", only_friends: "only_friends" , public_event: "public_event" }

  def get_attending_friends(user)
    @friends = user.friends
    @attendees = self.attendees
    @attending_friends = @attendees & @friends

    if @attending_friends.empty?
      return "Be the first one of your friends to attend this party"
    elsif @attending_friends.length == 1
      name = @attending_friends.first.username
      return "#{name} is attending this party"
    elsif @attending_friends.length == 2
      name_2 = @attending_friends.first.username
      name_1 = @attending_friends.second.username
      return "#{name_1} and #{name_2} are attending this party"
    else 
      name_2 = @attending_friends.first.username
      name_1 = @attending_friends.second.username
      number = @attending_friends.length - 2 
      return "#{name_1}, #{name_2} and #{number} friends are attending this party"
    end
  end
end
