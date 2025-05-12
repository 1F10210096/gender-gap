module DiscussionThreads
  class Popular
    attr_reader :query, :summarizer, :gender

    def initialize(query:, summarizer:, gender:)
      @query = query
      @summarizer = summarizer
      @gender = gender
    end

    def self.call(
      query: ::DiscussionThreadsQuery::Popular.new,
      summarizer: PostWithVoteSummary,
      gender: Gender
    )
      new(query: query, summarizer: summarizer, gender: gender).call
    end

    def call
      popular_threads_cache
    end

    private

    def popular_threads_cache
      Rails.cache.fetch("popular_threads", expire_in: Rails.application.config.cache_expiry[:popular_threads]) do
        thread_popular_with_votes
      end
    end

    def thread_popular_with_votes
      Rails.logger.info("Popular threads query result: #{query.popular.inspect}")
      query.popular.map do |thread|
        summarizer.call(thread: thread, gender: gender)
      end
    end
  end
end