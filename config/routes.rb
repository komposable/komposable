Komposable::Engine.routes.draw do
  root "users#index"
  resources :medias
  resources :user_sessions
  resources :users
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
