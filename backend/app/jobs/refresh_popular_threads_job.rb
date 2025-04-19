class RefreshPopularThreadsJob < ApplicationJob
  queue_as :default

  def perform
    threads = DiscussionThreadQuery.new.popular
    json = threads.map do |thread|
      {
        id: thread.id,
        thread_title: thread.thread_title,
        created_at: thread.created_at,
        updated_at: thread.updated_at,
        image_key: thread.try(:image_key),
        comments_count: thread.attributes["comments_count"].to_i,
        votes_summary: {
          male_votes: thread.attributes["male_votes"].to_i,
          female_votes: thread.attributes["female_votes"].to_i
        }
      }
    end

    Rails.cache.write("popular_threads", json, expires_in: 10.minutes)
  end
end
