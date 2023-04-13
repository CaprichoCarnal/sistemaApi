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
  # Defines the root path route ("/")
  # root "articles#index"
end
