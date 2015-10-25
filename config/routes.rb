Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    member do
      get :statistics
    end
  end

  resources :projects, only: [:index, :show, :create, :new] do
    member do
      put :update_info
    end
    collection do
      put :commits_frequency
    end
  end

  root "dashboard#index"

end
