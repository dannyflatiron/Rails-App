Rails.application.routes.draw do
  root to: "welcome#home"

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth' }

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  

  resources :messages

  # Nested Routes
  resources :users, only: [:show] do 
    resources :missions, only: [:new, :create, :index, :show]
    resources :messages, shallow: true
  end
  resources :missions do 
    resources :messages
  end

  resources :categories, only: [:index, :show]
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
