Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "employee#index"
  get "employee_dashboard", to: "employee#dashboard", as: :employee_dashboard
  get "employee/index", to: "employee#index"
  post "employee/index", to: "employee#create"
  resources :employee do
    collection do
      get :search
    end
  end
  resources :department

  get "department/index", to: "department#index"
  post "department/index", to: "department#create"

  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"

  # delete "employee/:id", to: "employee#destroy"
  # Defines the root path route ("/")
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
