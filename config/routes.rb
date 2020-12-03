Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # HOME
  root to: 'pages#home'

  get '/uikit', to: 'pages#uikit', as: 'uikit'
  get '/about', to: 'pages#about', as: 'about'
  get '/contact', to: 'pages#contact', as: 'contact'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # ADMIN-TASKS admin/beers + DELETE, admin/breweries + DELETE
  # Cancelled : Rails admin gem used instead
  # namespace :admin do
  #   resources :beers, only: %i[index destroy]
  #   resources :breweries, only: %i[index destroy]
  #   get '/validation', to: 'pages#validation'
  # end

  # SEARCH-BEER-TYPING+BEER-RESULTS
  # get '/search', to: 'pages#search', as: 'search'
  resources :searches, only: %i[index], path: "search"

  # CELLARS-LISTS /lists + BEER-LISTS /lists/:id
  resources :lists, only: %i[index show new create edit update destroy] do
    resources :contents, only: %i[new create destroy]
  end

  # BREWERY-INFO
  resources :breweries, only: %i[index new create edit update show]



  # BEER-INFO
  resources :beers  do
    resources :reviews, only: %i[new create edit update]
    collection do
      get 'validation'
    end
    member do
      patch 'validate'
      patch 'decline'
    end
  end
end
