module DiscussionThreadsQuery
  class Recommended
    attr_reader :limit

    def initialize(limit = 3)
      @limit = limit
    end

    def recommend
      DiscussionThread
        .preload(posts: :votes) 
        .left_joins(:posts)
        .joins("INNER JOIN recommended_threads ON recommended_threads.discussion_thread_id = discussion_threads.id")
        .group(:id, :recommended_at)
        .select('discussion_threads.*, COUNT(posts.id) AS comments_count, MAX(recommended_threads.recommended_at) AS recommended_at') # recommended_atを取得
        .order("recommended_at DESC")
        .limit(@limit)
    end
  end
end
