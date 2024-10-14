Rails.application.routes.draw do
  get "images/show"
  get "page/:slug", to: "pages#show", slug: /[-a-z0-9+]*/, as: :page
  get "search/:year/:month", to: "search#index", year: /\d{4}/, month: /\d{2}/
  get "search", to: "search#index"
  get "tags/:name", to: "tags#show", name: /[-a-z0-9+]*/, as: :tag

  resources :images, only: :show
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
end
