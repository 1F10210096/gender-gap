module Api
    module V1
      module DiscussionThreads
        class PopularController < ApplicationController
          def index
            render_json_response(::DiscussionThreads::Popular.call)
          end
        end
      end
    end
end