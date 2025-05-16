module DiscussionThreads
  class WeeklyPopular
    attr_reader :query, :summarizer

    def initialize(query:,summarizer:)
      @query = query
      @summarizer = summarizer
    end

    def self.call(query: DiscussionThreadQuery.new, summarizer: PostWithVoteSummary)
        new(query: query, summarizer: summarizer).call
    end

    def call
      popular_weekly_threads_cache
    end

    private

    def popular_weekly_threads_cache
      Rails.cache.fetch("weekly_popular_threads", expire_in: Rails.application.config.cache_expiry[:popular_weekly_threads]) do
        thread_weekly_popular_with_votes
      end
    end

    def thread_weekly_popular_with_votes
      query.weekPopular.map do |thread|
        summarizer.call(thread: thread)
      end
    end
  end
end