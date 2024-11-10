Rails.application.routes.draw do
  # Configuración de Devise para usuarios autenticados y no autenticados
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords' 
  }, skip: [:registrations]

  devise_scope :user do
    authenticated :user do
      root to: "home#index", as: :authenticated_root
    end

    unauthenticated :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end

    # Rutas adicionales para la edición de perfil y cambio de contraseña
    get 'users/edit', to: 'devise/registrations#edit', as: :edit_user_registration
    put 'users', to: 'devise/registrations#update', as: :user_registration
  end

  # Rutas de registro y notificación de registros
  get "register", to: "registrations#new", as: :register
  post "register", to: "registrations#create"

  # Rutas para el administrador
  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :applications, only: [:index, :show, :destroy] do
      member do
        patch :update_status
      end
    end
  end
  

  # Rutas para ofertas de trabajo y aplicaciones
  resources :job_offers, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :applications, only: [:new, :create, :index, :update, :destroy]

  # Ruta de salud para monitoreo
  get "up" => "rails/health#show", as: :rails_health_check

  # Rutas para configuración de PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
