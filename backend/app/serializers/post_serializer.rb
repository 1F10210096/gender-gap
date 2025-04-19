class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :discussion_thread_id, :gender, :created_at, :image_key

  has_many :votes
end
