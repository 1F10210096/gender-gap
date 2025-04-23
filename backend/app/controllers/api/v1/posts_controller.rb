module Api
    module V1
        class PostsController < ApplicationController
            def index
                discussion_thread_id = params[:discussion_thread_id]
                cache_key = "thread:#{discussion_thread_id}:posts_json"

                json = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
                    content = PostsQuery.fetch_by_discussion_thread(discussion_thread_id)
                    if content.present?
                        render_to_string(json: content, each_serializer: PostSerializer)
                    else
                        nil
                    end
                end
                if json.present?
                    render json: JSON.parse(json)
                else
                    render json: { error: "Post not found for this discussion_thread_id" }, status: :not_found
                end
            end
            def show
                content = Post.where(discussion_thread_id: params[:discussion_thread_id])
                if content
                    render_json_response(content)
                else
                    render json: { error: "Post not found for this discussion_thread_id" }, status: :not_found
                end
            end
            def create
                content = Post.build_new(content_params,@current_user.id)
                if content.save 
                    Rails.cache.delete("thread:#{content.discussion_thread_id}:posts_json")
                    render_json_response({content:content}, status: :created)
                else
                    render_json_response({ errors: content.errors.full_messages }, status: :unprocessable_entity)
                end
            end

            private
            def content_params
                params.require(:post).permit(:content, :discussion_thread_id, :gender, :image_key, :reply_to_id)
            end
        end
    end
end
