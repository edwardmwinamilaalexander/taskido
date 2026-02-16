Rails.application.routes.draw do
  get "tasks/index"
  get "tasks/new"
  get "tasks/show"
  get "tasks/edit"
 
  devise_for :users
  resources :tasks
  root "pages#home"
  get "/about", to: "pages#about"
end