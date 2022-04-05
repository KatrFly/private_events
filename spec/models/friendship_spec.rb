require 'rails_helper'

RSpec.describe FriendRequest, :type => :model do
  describe '#get_the_users_friend' do
    it 'returns the correct person in the friendship if it\'\s friend column contains the friend' do
      user = create(:user)
      friend = create(:user)
      friendship = create(:friendship, user: user, friend: friend)

      expect(friendship.get_the_users_friend(user)).to be(friend)
    end

    it 'returns the correct person in the friendship if it\'\s user column contains the friend' do
      user = create(:user)
      friend = create(:user)
      friendship = create(:friendship, user: friend, friend: user)

      expect(friendship.get_the_users_friend(user)).to be(friend)
    end
  end
end