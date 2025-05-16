module Api
    module V1
      module DiscussionThreads
        class WeeklyPopularController < ApplicationController
          def index
            render_json_response(::DiscussionThreads::WeeklyPopular.call)
          end
        end
      end
    end
end
  