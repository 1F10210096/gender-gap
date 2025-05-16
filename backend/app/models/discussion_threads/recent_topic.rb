module DiscussionThreads
  class RecentTopic
    attr_reader :query, :summarizer, :gender

    def initialize(query:, summarizer:, gender:)
      @query = query
      @summarizer = summarizer
      @gender = gender
    end


    def self.call(
      query: ::DiscussionThreadsQuery::Recent.new,
      summarizer: PostWithVoteSummary,
      gender: Gender
    )
      new(query: query, summarizer: summarizer, gender: gender).call
    end

    def call
      recent_threads_cache
    end

    private

    def recent_threads_cache
      Rails.cache.fetch("recent_threads", expire_in: Rails.application.config.cache_expiry[:recent_threads]) do
        thread_recent_with_votes
      end
    end

    def thread_recent_with_votes
      query.recent.map do |thread|
        summarizer.call(thread: thread, gender: gender)
      end
    end
  end
end