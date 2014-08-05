Rails.application.routes.draw do
  root "task_lists#index"
  get "signin" => "sessions#new", as: :signin
  get "signout" => "sessions#destroy", as: :signout
  get "about" => "sessions#about"
  get "task_lists/new" => "task_lists#new"
  post "task_lists" => "task_lists#create"
  get "task_lists/:id/edit" => "task_lists#edit"
  patch "task_lists/:id" => "task_lists#update"
  get "task_lists/:id/tasks/new" => "tasks#new"
  post "task_lists/:id/tasks" => "tasks#create"
  post "signin" => "sessions#create"
  delete "task_lists/:id/tasks/:id" => "tasks#destroy"

end
