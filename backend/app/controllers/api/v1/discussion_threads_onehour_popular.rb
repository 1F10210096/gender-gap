module Api
    module V1
        class DiscussionThreadsOnehourPopular < DiscussionThreadsController
            def index
                render_json_response(DiscussionThreadRecentPopular.call)
            end
        end
    end
end