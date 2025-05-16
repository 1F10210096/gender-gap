class User < ApplicationRecord
  has_many :posts
  has_many :votes

  enum gender: { unknown: 0, male: 1, female: 2 }

  def voter_for(post)
    {
      "male"   => Voters::MaleVoter,
      "female" => Voters::FemaleVoter,
      "unknown"=> Voters::NullVoter
    }.fetch(gender).new(post)
  end
end