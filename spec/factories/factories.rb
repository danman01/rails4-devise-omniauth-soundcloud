# This will guess the User class
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    password 'mypass123'
  end

end
