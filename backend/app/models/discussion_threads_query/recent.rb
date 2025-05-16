module DiscussionThreadsQuery
  class Recent
    attr_reader :limit

    def initialize(limit = 10)
      @limit = limit
    end

    def recent
      DiscussionThread
        .includes(posts: :votes)
        .left_joins(:posts)
        .select('discussion_threads.*, COUNT(posts.id) AS comments_count')
        .group('discussion_threads.id, discussion_threads.created_at')
        .order('discussion_threads.created_at DESC')
        .limit(@limit)
    end
  end
end
