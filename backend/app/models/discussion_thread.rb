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

  # 人気のスレッドを取得（直近1週間のコメント数が多い順）
  def self.fetch_week_popular
    threads = DiscussionThreadQuery.new.weekPopular # 直近1週間の人気スレッドを取得
    threads.map do |thread|
      male_votes = 0
      female_votes = 0

      # 各スレッドに関連するポストと「いいね」を集計
      posts = thread.posts.includes(:votes) # 関連するポストと「いいね」を取得
      posts.each do |post|
        if post.gender == 1 # 男性のポスト
          male_votes += post.votes.where(gender: 1).count
        elsif post.gender == 2 # 女性のポスト
          female_votes += post.votes.where(gender: 2).count
        end
      end

      # スレッド情報と集計結果を返す
      {
        id: thread.id,
        thread_title: thread.thread_title,
        created_at: thread.created_at,
        updated_at: thread.updated_at,
        comments_count: thread.posts.count,
        votes_summary: {
          male_votes: male_votes,
          female_votes: female_votes
        }
      }
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