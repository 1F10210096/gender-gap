module DiscussionThreads
  class OnehourPopular
    attr_reader :query, :summarizer, :gender

    def initialize(query:, summarizer:, gender:)
      @query = query
      @summarizer = summarizer
      @gender = gender
    end

    def self.call(
      query: ::DiscussionThreadsQuery::OnehourPopular.new,
      summarizer: PostWithVoteSummary,
      gender: Gender
    )
      new(query: query, summarizer: summarizer, gender: gender).call
    end

    def call
      popular_onehour_threads_cache
    end

    private

    def popular_onehour_threads_cache
      Rails.cache.fetch("onehour_threads", expire_in: Rails.application.config.cache_expiry[:recent_popular_threads]) do
        thread_onehour_popular_with_votes
      end
    end

    def thread_onehour_popular_with_votes
      query.onehourPopular.map do |thread|
        summarizer.call(thread: thread, gender: gender)
      end
    end
  end
end