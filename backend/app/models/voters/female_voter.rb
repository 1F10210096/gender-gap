module Voters
  class FemaleVoter
    attr_reader :vote

    def initialize(vote)
      @vote = vote
    end

    def vote_count
      1
    end

    def category
      :female_votes
    end
  end
end
