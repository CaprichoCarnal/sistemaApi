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
      resources :vats
      resources :elaborated_products
      resources :article_names
      resources :elaborated_product_materials
      resources :inventories
      resources :sales
      resources :sale_items
      resources :invoices
      resources :traceabilities
      resources :cuts, only: [:index, :show, :create, :update, :destroy]
      resources :raw_materials_available, only: [:index, :update]

      get '/reports/available_for_cutting', to: 'reports#count_available_for_cutting'
      get '/reports/cutting_finished', to: 'reports#count_cutting_finished'
      get '/reports/partial_cutting', to: 'reports#count_partial_cutting'
      get '/reports/best_selling_products/weekly', to: 'reports#best_selling_products_weekly'
      get '/reports/best_selling_products/monthly', to: 'reports#best_selling_products_monthly'
      get '/reports/best_selling_products/yearly', to: 'reports#best_selling_products_yearly'
      get '/reports/paid_purchases/raw_materials', to: 'reports#paid_purchases_report_raw_materials'
      get '/reports/unpaid_purchases/raw_materials', to: 'reports#unpaid_purchases_report_raw_materials'
      get '/reports/paid_purchases/supplies', to: 'reports#paid_purchases_report_supplies'
      get '/reports/unpaid_purchases/supplies', to: 'reports#unpaid_purchases_report_supplies'
      get '/reports/iva_balance/raw_materials', to: 'reports#iva_balance_raw_materials'
      get '/reports/iva_balance/supplies', to: 'reports#iva_balance_supplies'
      get '/reports/invoices_status', to: 'reports#invoices_status_report'




    end
  end


   namespace :api do
    namespace :v1 do
      resources :users
      post "/auth/login", to: "authentication#login"
    end
  end





end
