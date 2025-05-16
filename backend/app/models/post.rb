class Post < ApplicationRecord
  belongs_to :discussion_thread, foreign_key: "discussion_thread_id"
  belongs_to :reply_to, class_name: 'Post', optional: true
  has_many :replies, class_name: 'Post', foreign_key: 'reply_to_id'
  belongs_to :user
  has_many :votes, dependent: :destroy 
  has_many :reports, dependent: :destroy
  has_one :votes_status, foreign_key: :post_id
  validates :gender, presence: true
  validates :content, presence: true
  scope :recent, -> {order(created_at: :desc)}
  def self.fetch_recent
    recent
  end

  def self.find_by_id(id)
    find(id)
  end

  def self.build_new(params,user_id)
    new(params.merge(user_id: user_id))
  end

  def self.reported
    PostsQuery.new.reported
  end

  def voter
    case gender
    when 1 then Voters::MaleVoter.new(self)
    when 2 then Voters::FemaleVoter.new(self)
    else Voters::NullVoter.new(self)
    end
  end
end