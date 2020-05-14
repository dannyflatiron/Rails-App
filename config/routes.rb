Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessiions: 'users/sessions'
  }
  root to: "welcome#home"
  
  resources :categories
  resources :messages
  resources :missions

  get '/auth/:provider/callback' => 'sessions#omniauth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
