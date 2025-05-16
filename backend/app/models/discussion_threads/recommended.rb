module DiscussionThreads
  class Recommended
    
    attr_reader :query, :summarizer

    def initialize(query:,summarizer:)
      @query = query
      @summarizer = summarizer
    end

    def self.call(query: ::DiscussionThreadsQuery::Recommended.new, summarizer: PostWithVoteSummary)
        new(query: query, summarizer: summarizer).call
    end

    def call
      recommend_threads_cache
    end

    private

    def recommend_threads_cache
      Rails.cache.fetch("recommended_threads", expire_in: Rails.application.config.cache_expiry[:recent_threads]) do
        thread_recommend_with_votes
      end
    end

    def thread_recommend_with_votes
      query.recommend.map do |thread|
        summarizer.call(thread: thread)
      end
    end
  end
end