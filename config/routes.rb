Rails.application.routes.draw do
  devise_for :users

  # HOME
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # ADMIN-TASKS admin/beers + DELETE, admin/breweries + DELETE
  namespace :admin do
    resources :beers, only: %i[index destroy]
    resources :breweries, only: %i[index destroy]
  end

  # SEARCH-BEER-TYPING+BEER-RESULTS
  get '/search', to: 'pages#search', as: 'search'

  # CELLARS-LISTS /lists + BEER-LISTS /lists/:id
  resources :lists, only: %i[index new create show destroy] do
    resources :contents, only: %i[new create destroy]
  end

  # BREWERY-INFO
  resources :breweries %i[index new create show]

  # A priori non utilisé car affiché sur BEER-INFO /beers/:id
  resources :reviews, only: %i[new create update]

  # BEER-INFO
  resources :beers, only: %i[index new create show]  do
    collection do
      get 'validation'
    end
    member do
      patch 'validate'
      patch 'decline'
    end
  end
end
