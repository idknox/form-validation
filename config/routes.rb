Rails.application.routes.draw do
  root "task_lists#index"
  get "/signin" => "sessions#new", as: :signin
  get "/signout" => "sessions#destroy", as: :signout
  get "/about" => "sessions#about"
  post "/signin" => "sessions#create"
  patch "/task_lists/:task_list_id/tasks/:id/completed" => "tasks#complete", as: :task_complete
  get "/task_lists/:id/completed" => "task_lists#show_completed", as: :task_list_completed
  resources :task_lists do
    resources :tasks
  end

end
