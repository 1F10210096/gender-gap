class PostsQuery
  def all
    Post.all
  end

  def reported
    Post.joins(:reports)
        .select("posts.*, COUNT(reports.id) AS reports_count")
        .group("posts.id")
        .order("reports_count DESC")
  end

  def self.fetch_by_discussion_thread(discussion_thread_id)
    Post.includes(:votes)
        .where(discussion_thread_id: discussion_thread_id)
  end
end