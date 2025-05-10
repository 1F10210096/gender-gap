class DiscussionThreadPopular
  attr_reader :query, :summarizer

  def initialize(query:,summarizer:)
    @query = query
    @summarizer = summarizer
  end

  def self.call(query: DiscussionThreadQuery.new, summarizer: PostWithVoteSummary)
    new(query: query, summarizer: summarizer).call
  end

  def call
    thread_popular_with_votes
  end

  private

  def thread_popular_with_votes
    query.popular.map do |thread|
      summarizer.call(thread: thread)
    end
  end
end