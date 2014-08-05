Rails.application.routes.draw do
  root "task_lists#index"
  get "/signin" => "sessions#new", as: :signin
  get "/signout" => "sessions#destroy", as: :signout
  get "/about" => "sessions#about"
  post "/signin" => "sessions#create"

  resources :task_lists do
    resources :tasks
  end
end
