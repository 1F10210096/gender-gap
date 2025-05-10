module Voters
  class NullVoter
    def initialize(post); end

    def vote_count
      0
    end

    def category
      :unknown
    end
  end
end
