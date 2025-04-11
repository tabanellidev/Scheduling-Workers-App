Rails.application.routes.draw do
  
  get "jobs/week" => "jobs#week"
  get "cleaners/:id/week" => "cleaners#week", as: :cleaner_week
  get "cleaners/:id/summary" => "cleaners#summary", as: :cleaner_summary
  post "repeatable_jobs/copyall/" => "repeatable_jobs#copyall"
  post "repeatable_jobs/:id/copy" => "repeatable_jobs#copy"
  get "repeatable_jobs/cleaner_schedule/:id/" => "repeatable_jobs#cleaner_schedule"
  get "repeatable_jobs/site_schedule/:id/" => "repeatable_jobs#site_schedule"
  
  
  devise_for :users

  resources :jobs
  resources :cleaners
  resources :users
  resources :sites
  resources :repeatable_jobs
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  get '/notauthorized', to: 'home#notauthorized'
  

  # Defines the root path route ("/")
  root "home#index"
end
