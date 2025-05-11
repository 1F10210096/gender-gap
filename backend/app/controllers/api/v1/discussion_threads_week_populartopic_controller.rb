module Api
    module V1
        class DiscussionThreadsWeekPopulartopicController < ApplicationController
            def index
                render_json_response(DiscussionThreadWeeklyPopular.call)
            end
        end
    end
end