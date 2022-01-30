Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :test, only: %i[index]

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }

      namespace :auth do
        resources :sessions, only: %i[index]
      end

      namespace :student do
        resources :subjects, only: %i[index]
      end

      resources :schools
      resources :groups
      resources :subjects
      get '/notifications/group_index', to: 'notifications#group_index'
      get '/notifications/user_index', to: 'notifications#user_index'
      resources :notifications
      resources :notification_checks
      resources :group_directors
      get '/comments/all/:id', to: 'comments#all_show'
      resources :comments
      get '/notify_selves/user', to: 'notify_selves#user_index'
      resources :notify_selves
      get '/votes/count/:id', to: 'votes#count'
      resources :votes
    end
  end
end