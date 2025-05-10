class PostWithVoteSummary
  attr_reader :thread, :vote_counts

  def initialize(thread)
    @thread = thread
    @vote_counts = Hash.new(0)
  end

  def self.call(thread:) 
    new(thread).call
  end

  def call
    thread.posts.preload(:votes).each do |post|
      voter = post.voter
      vote_counts[voter.category] += voter.vote_count
    end

    build_summary
  end

  private

  def build_summary
    {
      id: thread.id,
      thread_title: thread.thread_title,
      created_at: thread.created_at,
      updated_at: thread.updated_at,
      comments_count: thread.posts.count,
      votes_summary: {
        male_votes: vote_counts[:male_votes],
        female_votes: vote_counts[:female_votes]
      }
    }
  end
end
