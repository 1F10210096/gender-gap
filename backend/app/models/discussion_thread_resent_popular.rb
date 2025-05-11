class DiscussionThreadRecentPopular
  attr_reader :query, :summarizer

  def initialize(query:,summarizer:)
    @query = query
    @summarizer = summarizer
  end

  def self.call(query: DiscussionThreadQuery.new, summarizer: PostWithVoteSummary)
      new(query: query, summarizer: summarizer).call
  end

  def call
    popular_recent_threads_cache
  end

  private

  def popular_recent_threads_cache
    Rails.cache.fetch("popular_threads", expire_in: Rails.application.config.cache_expiry[:recent_popular_threads]) do
      thread_recent_popular_with_votes
    end
  end

  def thread_recent_popular_with_votes
    query.onehourPopular.map do |thread|
      summarizer.call(thread: thread)
    end
  end
end