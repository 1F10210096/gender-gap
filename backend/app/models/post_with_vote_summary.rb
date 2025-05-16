class PostWithVoteSummary
  attr_reader :thread,:gender, :vote_counts

  def initialize(thread:, gender:)
    @thread = thread
    @gender = gender
    @vote_counts = Hash.new(0)
  end

  def self.call(thread:, gender:)
    new(thread: thread, gender: gender).call
  end

  def call
    all_votes.each do |vote|
      increment_vote_count(vote)
    end
    build_summary
  end

  def increment_vote_count(vote)
    voter_gender = voter_for(vote)
    vote_counts[voter_gender.category] += voter_gender.vote_count
  end

  def voter_for(vote)
    gender_decision(vote).voter
  end

  def all_votes
    thread.posts.preload(:votes).flat_map(&:votes)
  end

  def gender_decision(vote)
    gender.new(vote.gender, vote)
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
