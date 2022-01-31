FactoryBot.define do
  factory :client do
    slug { Faker::Internet.username }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end