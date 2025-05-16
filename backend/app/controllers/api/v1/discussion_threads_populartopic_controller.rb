module Api
    module V1
        class DiscussionThreadsPopulartopicController < ApplicationController
            def index
                render_json_response(DiscussionThreadPopular.call)
            end
        end
    end
end