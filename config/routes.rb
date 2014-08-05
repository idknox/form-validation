Rails.application.routes.draw do
  root "task_lists#index"
  get "signin" => "sessions#new", as: :signin
  get "signout" => "sessions#destroy", as: :signout
  get "about" => "sessions#about"
  get "task_lists/new" => "task_lists#new"
  get "task_lists/:id/edit" => "task_lists#edit"
  get "task_lists/:id/tasks/new" => "tasks#new"
  post "task_lists" => "task_lists#create"
  post "signin" => "sessions#create"
  post "task_lists/:id/tasks/new" => "tasks#create", as: :task_create
  patch "task_lists/:id" => "task_lists#update"
end
