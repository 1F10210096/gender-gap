module DiscussionThreadsQuery
  class WeeklyPopular
    attr_reader :limit

    def initialize(limit = 10)
      @limit = limit
    end

    def weekPopular
      DiscussionThread
        .preload(posts: :votes)
        .joins(:posts)
        .where('posts.created_at >= ?', 1.week.ago)
        .group('discussion_threads.id')
        .select('discussion_threads.*, COUNT(posts.id) AS comments_count')
        .order('comments_count DESC')
        .limit(@limit)
    end
  end
end
