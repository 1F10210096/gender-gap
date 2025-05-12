class Gender
  MALE = 1
  FEMALE = 2

  VOTER_MAP = {
    MALE => Voters::MaleVoter,
    FEMALE => Voters::FemaleVoter
  }.freeze

  attr_reader :gender, :entity

  def initialize(gender, entity)
    raise ArgumentError, "無効な性別です" unless [MALE, FEMALE].include?(gender)
    @gender = gender
    @entity = entity
  end

  def male?
    gender == MALE
  end

  def female?
    gender == FEMALE
  end

  def voter
    (VOTER_MAP[gender] || Voters::NullVoter).new(entity)
  end
end