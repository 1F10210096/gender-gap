module Api
    module V1
        class DiscussionThreadsNewtopicController < DiscussionThreadsController
            def index
                render_json_response(DiscussionThreadRecent.call)
            end
        end
    end
end