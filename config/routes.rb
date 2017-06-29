Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :groups do
    resources :comments
    member do
      post 'upvote'
    end
    collection do
      get :search
    end
  end

  resources :aboutme
  resources :categories

  root "groups#index"

end
