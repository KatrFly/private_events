FactoryBot.define do
  factory :user do
    username { "Katrien" }
    email { "#{username}@testmail.com" }
    password { "password" }
  end
end