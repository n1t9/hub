Rails.application.routes.draw do
  resources :tasks
  get "health_check", to: "rails/health#show", as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :rails_pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :rails_pwa_manifest

  root to: "home#index"

  resource :signup, only: %i[show create] do
    scope module: :signups do
      resource :setup, only: %i[show create]
    end
  end
  resource :signin, only: %i[show create]
  resource :signout, only: %i[create]
  resource :terms, only: %i[show]

  resources :categories, only: %i[show]
  resources :keywords, only: %i[show]
  resources :users, only: %i[show]
  resources :pages, only: %i[index show new create edit update destroy] do
    scope module: :pages do
      resource :follow, only: %i[create destroy]
      resource :profile_image, only: %i[show create]
      resources :reviews, only: %i[new create edit update destroy]
    end
  end
  resources :page_posts, only: %i[index show new create edit update destroy] do
    scope module: :page_posts do
      resource :cover_image, only: %i[create]
      resource :bookmark, only: %i[create destroy]
    end
  end
  resources :official_posts, only: %i[index show] do
    scope module: :official_posts do
      resource :cover_image, only: %i[create]
      resource :bookmark, only: %i[create destroy]
    end
  end
  resources :following_pages, only: %i[index]
  resources :bookmarks, only: %i[index]
  resources :mypages, only: %i[index]
  resource :settings, only: %i[show update] do
    scope module: :settings do
      resource :profile_image, only: %i[show create]
      resource :password, only: %i[show update]
    end
  end
end
