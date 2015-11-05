Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    member do
      get :statistics
      get :commits_frequency
      get :chart_statistics
    end
  end

  get 'widgets/activity_chart'
  get 'widgets/tags_duration_chart'

  root "dashboard#index"

end
