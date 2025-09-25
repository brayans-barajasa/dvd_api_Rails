Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :languages, only: [ :index, :show ]

      # Clientes
      resources :clients, only: [ :index, :show, :create, :update, :destroy ]
      # Customers
      resources :customers, only: [ :index, :show ]

      # Países y ciudades anidadas
      resources :countries, only: [ :index, :show ] do
        resources :cities, only: [ :index ]
      end

      # Ciudades y direcciones anidadas
      resources :cities, only: [ :index, :show ] do
        resources :addresses, only: [ :index ]
      end

      # Actores
      resources :actors, only: [ :index, :show ]

      # Películas
      resources :films, only: [ :index, :show ]

      # inventorio
      resources :inventories, only: [ :index, :show ]
    end
  end
end
