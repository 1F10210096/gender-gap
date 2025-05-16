module Voters
  class MaleVoter
    attr_reader :post

    def initialize(post)
      @post = post
    end

    def vote_count
      post.votes.where(gender: 1).count
    end

    def category
      :male_votes
    end
  end
end
