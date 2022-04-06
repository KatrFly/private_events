require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with valid attributes" do
    subject = build_stubbed(:user)
    expect(subject).to be_valid
  end

  it "is not valid without a password" do
    subject = build_stubbed(:user, password: "")
    expect(subject).not_to be_valid
  end

  it "is not valid without an email address" do
    subject = build_stubbed(:user, email: "")
    expect(subject).not_to be_valid
  end

  describe '#friendships' do
    before(:each) do
      @user = create(:user)
      @friend_one = create(:user)
      @friend_two = create(:user)
      @no_friend = create(:user)

      @fs_one = Friendship.create(user_id: @user.id, friend_id: @friend_one.id)
      @fs_two = Friendship.create(user_id: @friend_two.id, friend_id: @user.id)
    end

    it 'finds all the users friendships' do
      expect(@user.friendships).to include(@fs_one, @fs_two)
    end

    it 'finds all the users friends' do
      expect(@user.friends).to include(@friend_one, @friend_two)
    end

    it 'does not include users that are not friends' do
      expect(@user.friends).not_to include(@no_friend)
    end
  end

  describe '#friend_request_exists?' do
    before(:each) do
      @user = create(:user)
      @user_two = create(:user)
    end

    it 'returns nil if there are no friend requests in the database' do
      expect(@user.friend_request_exists?(@user_two)).to be_nil
    end

    it 'returns the request if there is a request from user to user_two' do
      request = create(:friend_request, inviter: @user, invitee: @user_two)
      expect(@user.friend_request_exists?(@user_two.id)).to eq(request)
    end

    it 'returns the request if there is a request from user_two to user' do
      request = create(:friend_request, inviter: @user_two, invitee: @user)
      expect(@user_two.friend_request_exists?(@user.id)).to eq(request)
    end

    it 'returns nil if there are friend requests but not including one between user and user_two' do
      @user_three = create(:user)
      request = create(:friend_request, inviter: @user_two, invitee: @user_three)
      expect(@user_two.friend_request_exists?(@user.id)).to be_nil
    end
  end

  describe '#already_attending?' do
    before(:each) do
      @user = create(:user)
      @event = create(:event, name: 'some event')
      @other_event = create(:event, name: 'another event')
    end

    it 'returns the attendance if a person is attending an event' do
      @attendance = create(:attendance, user: @user, event: @event)
      expect(@user.already_attending?(@event)).to eq(@attendance)
    end

    it 'returns nil if the user is not attending an event' do
      @attendance = create(:attendance, user: @user, event: @other_event)
      expect(@user.already_attending?(@event)).not_to eq(@attendance)
    end

    it 'returns nil if a person has zero attending events' do
      expect(@user.already_attending?(@event)).to be_nil
    end
  end
end