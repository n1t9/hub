Rails.application.routes.draw do
  get "health_check", to: "rails/health#show", as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :rails_pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :rails_pwa_manifest

  root to: "home#index"

  resource :signup, only: %i[show create]
  resource :signin, only: %i[show create]
  resource :signout, only: %i[create]
  resource :terms, only: %i[show]

  resources :categories, only: %i[show]
end
