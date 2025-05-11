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

  # ID からスレッドを取得（例外処理は Controller 側で行う）
  def self.find_by_id(id)
    find(id)
  end

  # 新規作成用
  def self.build_new(params)
    new(params)
  end
end