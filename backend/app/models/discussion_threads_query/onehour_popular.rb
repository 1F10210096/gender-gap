module DiscussionThreadsQuery
  class OnehourPopular
    attr_reader :limit

    def initialize(limit = 10)
      @limit = limit
    end

    def onehourPopular
      DiscussionThread
        .preload(posts: :votes)
        .joins(:posts)
        .left_outer_joins(posts: :votes)
        .where('posts.created_at >= ?', 1.hour.ago)
        .group('discussion_threads.id')
        .select('discussion_threads.*, COUNT(posts.id) AS comments_count')
        .order('comments_count DESC')
        .limit(@limit)
    end
  end
end
