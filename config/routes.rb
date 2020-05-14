Rails.application.routes.draw do
  root to: "welcome#home"

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth' }

  
  resources :categories
  resources :messages
  resources :missions

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
