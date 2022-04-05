require 'rails_helper'

RSpec.describe FriendRequest, :type => :model do
  describe '#no_friends_yet' do
    before(:each) do
      @user = create(:user)
      @other_user = create(:user)
      @friend_request = build(:friend_request, inviter: @user, invitee: @other_user)
    end

    it 'returns no error when the users aren\'\t friends yet and no friend request has been send' do
      expect(@friend_request).to be_valid
    end

    it 'returns an error when a friend request has already been send' do
      already_existing_friend_request = create(:friend_request, inviter: @other_user, invitee: @user)
      expect(@friend_request).not_to be_valid
    end

    it 'returns an error when the users are already friends' do
      friendship = create(:friendship, user: @user, friend: @other_user)
      expect(@friend_request).not_to be_valid
    end
  end
end