FactoryBot.define do
  factory :user, aliases: [:creator] do
    username { generate(:username) }
    email { "#{username}@testmail.com" }
    password { "password" }
  end

  sequence :username do |n|
    "user_#{n}"
  end

  factory :friend_request do
  end

  factory :event do
    creator
  end

  factory :attendance do
    event
    user
  end

  factory :friendship do

  end

  factory :invitation do
    event
    user
  end
end