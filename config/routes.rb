Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :families
    end
  end

  namespace :api do
    namespace :v1 do
      resources :suppliers
    end
  end

  namespace :api do
    namespace :v1 do
      resources :customers
    end
  end

  namespace :api do
    namespace :v1 do
      resources :roles
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

   namespace :api do
    namespace :v1 do
      resources :users
      post "/auth/login", to: "authentication#login"
    end
  end

  
  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :document_types
    end
  end
  namespace :api do
    namespace :v1 do
      resources :locations
    end
  end
  namespace :api do
    namespace :v1 do
      resources :channels
    end
  end

  namespace :api do
    namespace :v1 do
      resources :supplies
    end
  end

  namespace :api do
    namespace :v1 do
      resources :historic_quarterings
      resources :historical_elaborations
      resources :process_histories
    end
  end


end
