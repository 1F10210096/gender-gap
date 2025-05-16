module DiscussionThreads
  class WeeklyPopular
    attr_reader :query, :summarizer, :gender

    def initialize(query:, summarizer:, gender:)
      @query = query
      @summarizer = summarizer
      @gender = gender
    end

    def self.call(
      query: ::DiscussionThreadsQuery::WeeklyPopular.new,
      summarizer: PostWithVoteSummary,
      gender: Gender
    )
      new(query: query, summarizer: summarizer, gender: gender).call
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
        summarizer.call(thread: thread, gender: gender)
      end
    end
  end
end