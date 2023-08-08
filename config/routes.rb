Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'recipes#public_recipes'

  get 'public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'

  resources :users do
    resources :recipes, only: [:index, :show, :new, :create, :destroy] do
      resources :recipe_foods, only: [:show, :new, :create, :destroy]
      get 'shopping_list', to: 'recipes#shopping_list', as: 'shopping_list' do
    end
  end
end

resources :foods, only: [:index, :show, :new, :create, :destroy]
resources :recipes, only: [:index, :show, :new, :create, :destroy]
end
