FactoryBot.define do
  factory :vote do
    association :post
    association :user
    vote_type { 1 }
    gender { [1, 2].sample }
    created_at { Time.current }
    updated_at { Time.current }
  end
end