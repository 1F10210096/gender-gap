module Voters
  class MaleVoter
    attr_reader :vote

    def initialize(vote)
      @vote = vote
    end

    def vote_count
      1
    end

    def category
      :male_votes
    end
  end
end
