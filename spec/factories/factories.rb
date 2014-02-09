# This will guess the User class
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'mypass123'
  end

end
