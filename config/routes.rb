Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :lists, only: %i[index new create show destroy] do 
    resources :contents, only: %i[new create destroy]
  end

  resources :breweries
  resources :reviews, only: %i[new create edit update]
  
  resources :beers do
    collection do
      get 'validation'
    end
    member do 
      patch 'validate'
      patch 'decline'
    end
  end
end
