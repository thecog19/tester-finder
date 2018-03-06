Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :user, only: [:show, :index]
  post 'search', to: "user#search"
  root "user#index"
end
