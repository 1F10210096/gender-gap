module Api
    module V1
        class DiscussionThreadsOnehourPopular < DiscussionThreadsController
            def index
                onefourPopularThreads = DiscussionThread.fetch_onehour_popular
                render_json_response(onefourPopularThreads)
            end
        end
    end
end