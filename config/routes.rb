Rails.application.routes.draw do
  devise_for :users
  resources :tasks do
    member do
      put :change_state
    end
  end
  root "pages#home"
  get "/about", to: "pages#about"
end
