Rails.application.routes.draw do
  root to: "welcome#home"

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth' }

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  resources :messages

  # Nested Routes
  resources :users, only: [:show] do 
    resources :posts, only: [:new, :create, :index]
  end
  resources :missions do 
    resources :messages, only: [:new, :create, show]
  end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
