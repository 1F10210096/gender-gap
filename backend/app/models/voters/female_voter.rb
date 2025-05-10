module Voters
  class FemaleVoter
    attr_reader :post

    def initialize(post)
      @post = post
    end

    def vote_count
      post.votes.where(gender: 2).count
    end

    def category
      :female_votes
    end
  end
end
