module Api
    module V1
      module DiscussionThreads
        class RecentController < ApplicationController
            def index
            render_json_response(::DiscussionThreads::RecentTopic.call)
            end
        end
      end
    end
end