Rails.application.routes.draw do
  resources :posts
  resources :users
  get 'main', to: 'main#main'
  post 'main', to: 'main#login'
  get 'feed', to: 'main#feed'
  get 'profile/:name', to: 'main#profile'
  post 'follow', to: 'follow#create'
  post 'unfollow', to: 'follow#destroy'
  get 'register', to: 'main#register'
  post 'register', to: 'main#create_user'
  post 'like', to: 'like#create'
  post 'unlike', to: 'like#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
