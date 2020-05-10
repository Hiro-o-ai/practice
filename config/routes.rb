Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "books#top"
  get "home/about", to: "books#about", as: "about_home"
  get "search", to: "searches#search"
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end


  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :following, :followers
    end
  end
  resources :rooms, only: [:create,:show] do
    resources :chats, only: [:create]
  end
end