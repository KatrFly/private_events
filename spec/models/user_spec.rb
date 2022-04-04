require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with valid attributes" do
    subject = build(:user)
    expect(subject).to be_valid
  end

  it "is not valid without a password" do
    subject = build(:user, password: "")
    expect(subject).not_to be_valid
  end

  it "is not valid without an email address" do
    subject = build(:user, email: "")
    expect(subject).not_to be_valid
  end

  describe 'user with friendships' do
    xit 'finds all the users friendships' do

    end
  end
end