require 'rails_helper'

#  TODO: write tests to check if the error messages are added.

RSpec.describe Attendance, :type => :model do
  describe '#only_allowed_people_can_attend' do
    context 'the event is only for friends' do
      it 'raises an error if people who are not friends try to attend the event' do
        user = create(:user)
        event = create(:event, visibility: "only_friends")
        attendance = build(:attendance, user: user, event: event)

        expect(attendance).not_to be_valid
      end

      it 'is valid when the user and the creator are friends' do
        user = create(:user)
        attending_friend = create(:user)
        event = create(:event, visibility: "only_friends", creator: user)
        attendance = build(:attendance, user: attending_friend, event: event)
        friendship = create(:friendship, user: user, friend: attending_friend)

        expect(attendance).to be_valid
      end
    end

    context 'the event is only for invited persons' do
      it 'raises an error if people who are not invited try to attend the event' do
        user = create(:user)
        event = create(:event, visibility: "only_invited")
        attendance = build(:attendance, event: event, user: user)

        expect(attendance).not_to be_valid
      end

      it 'is valid when the user is invited' do
        invited_user = create(:user)
        event = create(:event, visibility: "only_invited")
        invitation = create(:invitation, user: invited_user, event: event)
        attendance = build(:attendance, event: event, user: invited_user)

        expect(attendance).to be_valid
      end
    end

    context 'the event is public' do
      it 'is valid for random users' do
        user = create(:user)
        event = create(:event, visibility: "public_event")
        attendance = build(:attendance, event: event, user: user)

        expect(attendance).to be_valid
      end
    end
  end
end