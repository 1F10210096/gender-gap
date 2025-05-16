class DiscussionThread < ApplicationRecord
  has_many :posts, dependent: :destroy, foreign_key: "discussion_thread_id"

  def self.create_with_post(thread_params, post_params,user_id)
    ActiveRecord::Base.transaction do
      thread = create!(thread_params)

      thread.posts.create!(
        content: post_params[:content],
        gender: post_params[:gender],
        user_id: user_id,
        image_key:post_params[:image_url]
      )
    return thread
  end

  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to create DiscussionThread with Post: #{e.message}"
    return DiscussionThread.new 
  end

  # 最近のスレッドを取得
  def self.fetch_recent
    DiscussionThreadQuery.new.recent
  end

  # 人気のスレッドを取得（直近1時間のコメント数が多い順）
  def self.fetch_onehour_popular
    Rails.cache.fetch("onehour_popular_threads",expire_in: 1.hour) do
      threads = DiscussionThreadQuery.new.onehourPopular # 直近1時間の人気スレッドを取得
      Rails.logger.info("Fetched one hour popular threads: #{threads.inspect}")

      threads.map do |thread|
        {
          id: thread.id,
          thread_title: thread.thread_title,
          created_at: thread.created_at,
          updated_at: thread.updated_at,
          image_key: thread.try(:image_key),
          comments_count: thread.attributes["comments_count"].to_i,
          votes_summary: {
            male_votes: thread.attributes["male_votes"].to_i,
            female_votes: thread.attributes["female_votes"].to_i
        }
        }
      end
    end
  end

  # ID からスレッドを取得（例外処理は Controller 側で行う）
  def self.find_by_id(id)
    find(id)
  end

  # 新規作成用
  def self.build_new(params)
    new(params)
  end
end