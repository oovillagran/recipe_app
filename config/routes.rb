Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'recipes#index'

  resources :users do
    resources :recipes, only: [:index, :show, :new, :create, :destroy] do
      member do
      patch 'toggle'
      end
      resources :recipe_foods, only: [:show, :new, :create, :destroy]
    end
    get 'shopping_list', to: 'users#shopping_list', as: 'shopping_list' do
  end
end

resources :foods, only: [:index, :show, :new, :create, :destroy]
resources :recipes, only: [:index, :show, :new, :create, :destroy]

resources :public_recipes, only: [:index]
end
