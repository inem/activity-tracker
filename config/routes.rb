Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    member do
      get :statistics
      get :commits_frequency
      get :chart_statistics
    end
  end

  root "dashboard#index"

end
