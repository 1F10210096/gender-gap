module Api
    module V1
      module DiscussionThreads
        class OnehourPopularController < ApplicationController
          def index
            render_json_response(::DiscussionThreads::OnehourPopular.call)
          end
        end
      end
    end
end
  