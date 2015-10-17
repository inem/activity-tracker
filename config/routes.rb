Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    member do
      get :statistics
    end
  end

  root "dashboard#index"

end
