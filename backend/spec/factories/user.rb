FactoryBot.define do
  factory :user do
    ip_address { Faker::Internet.unique.ip_v4_address }
    gender { [1, 2].sample }
  end
end