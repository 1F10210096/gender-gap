class DiscussionThreadRecent
  attr_reader :query, :summarizer

  def initialize(query:,summarizer:)
    @query = query
    @summarizer = summarizer
  end

  def self.call(query: DiscussionThreadQuery.new, summarizer: PostWithVoteSummary)
      new(query: query, summarizer: summarizer).call
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
      summarizer.call(thread: thread)
    end
  end
end