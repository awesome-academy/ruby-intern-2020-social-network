Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "posts#index"

    get "/signup", to: "users/users#new"
    post "signup", to: "users/users#create"
    get "/signin", to: "users/sessions#new"
    post "/signin", to: "users/sessions#create"
    delete "/logout", to: "users/sessions#destroy"
    namespace :users do
      resources :password_resets, except: %i(index show destroy)
      resources :users do
        resources :images, only: %i(index new)
      end
      resources :intro_users
    end
    resources :posts do
      resources :likes
    end
    resources :topics
  end
end
