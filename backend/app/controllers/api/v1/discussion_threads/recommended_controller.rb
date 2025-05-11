module Api
  module V1
    module DiscussionThreads
        class RecommendedController < ApplicationController
            def index
              render_json_response(::DiscussionThreads::Recommended.call)
            end
        end
    end
  end
end