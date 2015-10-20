Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    member do
      get :statistics
    end
  end

  resources :projects, only: [:index, :show, :create]

  root "dashboard#index"

end
