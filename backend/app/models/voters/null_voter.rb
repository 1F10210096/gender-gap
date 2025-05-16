module Voters
  attr_reader :vote
  
  class NullVoter
    def initialize(vote); end

    def vote_count
      0
    end

    def category
      :unknown
    end
  end
end
