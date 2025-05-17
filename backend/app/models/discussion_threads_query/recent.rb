module DiscussionThreadsQuery
  class Recent
    attr_reader :limit

    def initialize(limit = 10)
      @limit = limit
    end

    def recent
      DiscussionThread
        .includes(posts: :votes)
        .order('discussion_threads.created_at DESC')
        .limit(@limit)
    end
  end
end
