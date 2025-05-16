FactoryBot.define do
  factory :discussion_thread do
    thread_title { "テストスレッドタイトル" }
    image_key { nil } # 必要なら画像キーを入れる
    created_at { Time.current }
    updated_at { Time.current }
  end
end