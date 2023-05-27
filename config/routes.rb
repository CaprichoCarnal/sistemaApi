Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :families
      resources :suppliers
      resources :customers
      resources :roles
      resources :users
      resources :document_types
      resources :locations
      resources :raw_materials
      resources :raw_material_purchases
      resources :historic_quarterings
      resources :historical_elaborations
      resources :process_histories
      resources :piece_names
      resources :piece_names_list
      resources :supplies
      resources :purchase_supplies
      resources :elaborated_products
      resources :article_names
      resources :elaborated_product_materials
      resources :inventories
      resources :sales
      resources :sale_items
      resources :cuts, only: [:index, :show, :create, :update, :destroy]
      resources :raw_materials_available, only: [:index, :update]
    end
  end


   namespace :api do
    namespace :v1 do
      resources :users
      post "/auth/login", to: "authentication#login"
    end
  end

  



end
