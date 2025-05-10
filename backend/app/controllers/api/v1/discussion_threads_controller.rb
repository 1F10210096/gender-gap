module Api
  module V1
    class DiscussionThreadsController < ApplicationController
      def show
        thread = DiscussionThread.find_by_id!(params[:id])
        render_json_response(thread)
      rescue ActiveRecord::RecordNotFound
        render_json_response({ error: "Thread not found" }, status: :not_found)
      end

      def create
        thread = DiscussionThread.create_with_post(thread_params, post_params,@current_user.id)
      
        if thread.persisted?
          render_json_response({ id: thread.id, thread_title: thread.thread_title,created_at:thread.created_at,image_key:thread.image_key }, status: :created)
        else
          render_json_response({ errors: thread.errors.full_messages }, status: :unprocessable_entity)
        end
      end

      private

      def thread_params
        params.require(:discussion_thread).permit(:thread_title,:created_at, :image_key)
      end

      def post_params
        params.require(:post).permit(:content, :gender, :image_key)
      end
    end
  end
end