FactoryBot.define do
  factory :post do
    association :discussion_thread
    association :user
    gender { [1, 2].sample } # 男性1 or 女性2 をランダム
    content { Faker::Lorem.paragraph }
    image_key { nil }
    reply_to_id { nil }
    created_at { Time.current }
    updated_at { Time.current }
  end
end