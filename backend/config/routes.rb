require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  get "/health", to: ->(_) { [200, {}, ["OK"]] }
  namespace :api do
    namespace :v1 do
      namespace :discussion_threads do
        get 'popular', to: 'popular#index'
        get 'recent', to: 'recent#index'
        get 'recommended', to: 'recommended#index'
        get 'week_popular', to: 'weekly_popular#index'
      end

      resources :discussion_threads, only: [:index, :show, :create]
      resources :posts, only: [:index, :show, :create], defaults: { format: :json } do
        resources :replies, only: [:create], controller: 'replies'
        resources :votes, only: [:create]
        resources :votes_status, only: [:index]
      end
      namespace :report do
        resources :posts_report, only: [:index,:create]
        get "report_contents/:post_id", to: "report_contents#show"
      end

      namespace :admin do
        post "/login", to: "admins#login"
        get "/admin", to: "admins#show"
        resources :discussion_threads_admin_topic, only: [:index, :destroy, :update]
        
        resources :discussion_threads_admin_recommended_topic, only: [:index, :destroy, :update] do
          collection do
            post 'bulk-delete', to: 'discussion_threads_admin_recommended_topic#bulk_delete'
            post 'bulk-add', to: 'discussion_threads_admin_recommended_topic#bulk_add'
          end
        end

        resources :discussion_threads_admin_posts, only: [:index, :destroy, :update]
      end
      get 'presigned_url', to: 'uploads#presigned_url'
      get 'img_download_url', to: 'img_downloads#presigned_url'
    end
    root to: ->(_) { [200, {}, ['OK']] }
  end
end
