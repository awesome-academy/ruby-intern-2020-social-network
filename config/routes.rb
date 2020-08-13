Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do

    get "/signup", to: "users/users#new"
    post "signup", to: "users/users#create"
    get "/signin", to: "users/sessions#new"
    post "/signin", to: "users/sessions#create"
    namespace :users do
      resources :password_resets, except: %i(index show destroy)
      resources :users
    end
    resources :topics
  end
end
