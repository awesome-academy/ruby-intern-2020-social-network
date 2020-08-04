Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "posts#index"

    get "/signup", to: "users/users#new"
    post "signup", to: "users/users#create"
    get "/signin", to: "users/sessions#new"
    post "/signin", to: "users/sessions#create"
    delete "/logout", to: "users/sessions#destroy"
    namespace :users do
      resources :follow_users, only: %i(create destroy)
      resources :password_resets, except: %i(index show destroy)
      resources :users do
        resources :images, only: %i(index new)
        resources :friend_requests, except: %i(new show edit)
      end
      resources :intro_users
    end
    resources :posts do
      resources :likes
      resources :comments
    end
    resources :topics
  end
end
