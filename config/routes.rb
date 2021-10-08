Rails.application.routes.draw do
  resources :posts
  resources :users
  get 'main', to: 'main#main'
  post 'main', to: 'main#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
