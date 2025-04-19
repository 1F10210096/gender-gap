class DiscussionThreadQuery
    attr_reader :limit
  
    def initialize(limit = 10)
      @limit = limit
    end
  
    def recent
      DiscussionThread
        .includes(posts: :votes)
        .left_joins(:posts)
        .select('discussion_threads.*, COUNT(posts.id) AS comments_count')
        .group('discussion_threads.id, discussion_threads.created_at')
        .order('discussion_threads.created_at DESC')
        .limit(@limit)
    end
  
    def popular
      DiscussionThread
      .joins(:posts)
      .left_outer_joins(posts: :votes)
      .where('posts.created_at >= ?', 1.day.ago)
      .group('discussion_threads.id')
      .select(
        'discussion_threads.id',
        'discussion_threads.thread_title',
        'discussion_threads.created_at',
        'discussion_threads.updated_at',
        'discussion_threads.image_key',
        'COUNT(posts.id) AS comments_count',
        "SUM(CASE WHEN posts.gender = 1 AND votes.gender = 1 THEN 1 ELSE 0 END) AS male_votes",
        "SUM(CASE WHEN posts.gender = 2 AND votes.gender = 2 THEN 1 ELSE 0 END) AS female_votes"
      )
      .order('comments_count DESC')
      .limit(@limit)
    end

    def weekPopular
      DiscussionThread
      .joins(:posts)
      .left_outer_joins(posts: :votes)
      .where('posts.created_at >= ?', 1.week.ago)
      .group('discussion_threads.id')
      .select(
        'discussion_threads.id',
        'discussion_threads.thread_title',
        'discussion_threads.created_at',
        'discussion_threads.updated_at',
        'discussion_threads.image_key',
        'COUNT(posts.id) AS comments_count',
        "SUM(CASE WHEN posts.gender = 1 AND votes.gender = 1 THEN 1 ELSE 0 END) AS male_votes",
        "SUM(CASE WHEN posts.gender = 2 AND votes.gender = 2 THEN 1 ELSE 0 END) AS female_votes"
      )
      .order('comments_count DESC')
      .limit(@limit)
    end

    def onehourPopular
      DiscussionThread
      .joins(:posts)
      .left_outer_joins(posts: :votes)
      .where('posts.created_at >= ?', 1.hour.ago)
      .group('discussion_threads.id')
      .select(
        'discussion_threads.id',
        'discussion_threads.thread_title',
        'discussion_threads.created_at',
        'discussion_threads.updated_at',
        'discussion_threads.image_key',
        'COUNT(posts.id) AS comments_count',
        "SUM(CASE WHEN posts.gender = 1 AND votes.gender = 1 THEN 1 ELSE 0 END) AS male_votes",
        "SUM(CASE WHEN posts.gender = 2 AND votes.gender = 2 THEN 1 ELSE 0 END) AS female_votes"
      )
      .order('comments_count DESC')
      .limit(@limit)
    end


end

   