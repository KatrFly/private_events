require 'rails_helper'

RSpec.describe Attendance, :type => :model do
  describe '#get_attending_friends' do
    before(:each) do
      @user = create(:user)
      @event = create(:event)
    end

    context 'no friends are attending the event' do
      it 'returns the correct sentence' do
        expect(@event.get_attending_friends(@user)).to eq("Be the first one of your friends to attend this party")
      end
    end

    context 'one friend is attending the event' do
      it 'returns the correct sentence with one username' do
        attending_friend = create(:user)
        friendship = create(:friendship, user: @user, friend: attending_friend)
        attendance = create(:attendance, user: attending_friend, event: @event)
        expect(@event.get_attending_friends(@user)).to eq("#{attending_friend.username} is attending this party")
      end
    end

    context 'two friends are attending the event' do
      it 'returns the correct sentence with two usernames' do
        attending_friend = create(:user)
        attending_friend_two = create(:user)

        friendship = create(:friendship, user: @user, friend: attending_friend)
        friendship_two = create(:friendship, user: @user, friend: attending_friend_two)

        attendance = create(:attendance, user: attending_friend, event: @event)
        attendance_two = create(:attendance, user: attending_friend_two, event: @event)

        expect(@event.get_attending_friends(@user)).to eq("#{attending_friend.username} and #{attending_friend_two.username} are attending this party")
      end
    end

    context 'three or more friends are attending the event' do
      it 'returns the correct sentence with two usernames and number of friends attending' do
        attending_friend = create(:user)
        attending_friend_two = create(:user)
        attending_friend_three = create(:user)
        attending_friend_four = create(:user)

        friendship = create(:friendship, user: @user, friend: attending_friend)
        friendship_two = create(:friendship, user: @user, friend: attending_friend_two)
        friendship_three = create(:friendship, user: @user, friend: attending_friend_three)
        friendship_four = create(:friendship, user: @user, friend: attending_friend_four)

        attendance = create(:attendance, user: attending_friend, event: @event)
        attendance_two = create(:attendance, user: attending_friend_two, event: @event)
        attendance_three = create(:attendance, user: attending_friend_three, event: @event)
        attendance_four = create(:attendance, user: attending_friend_four, event: @event)

        expect(@event.get_attending_friends(@user)).to eq("#{attending_friend.username}, #{attending_friend_two.username} and 2 friends are attending this party")
      end
    end
  end
end