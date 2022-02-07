Rails.application.routes.draw do
  constraints subdomain: 'buyer' do
    resources :buyers, controller: 'buyers', type: 'Buyer' do
      member do
        get '/orders/new', to: 'buyers#new_order', as: 'new_order'
        post '/orders/', to: 'buyers#create_order', as: 'create_order'
        get '/orders/:id', to: 'buyers#show_order', as: 'show_order'
        get '/orders/:id/edit', to: 'buyers#edit_order', as: 'edit_order'
        put '/orders/:id', to: 'buyers#update_order', as: 'update_order'
        delete '/orders/:id', to: 'buyers#destroy_order', as: 'destroy_order'
      end
    end
    
    root to: "buyers#home", as: :buyer_home
  end

  constraints subdomain: 'seller' do
    resources :sellers, controller: 'sellers', type: 'Seller' do

      member do
        get '/products/new', to: 'sellers#new_product', as: 'new_product'
        get '/products/', to: 'sellers#list_products', as: 'list_products'
        post '/products/', to: 'sellers#create_product', as: 'create_product'
        get '/products/:id', to: 'sellers#show_product', as: 'show_product'
        get '/products/:id/edit', to: 'sellers#edit_product', as: 'edit_product'
        put '/products/:id', to: 'sellers#update_product', as: 'update_product'
        delete '/products/:id', to: 'sellers#destroy_product', as: 'destroy_product'
      end

      namespace :product_details do
        get '/product_details/new', to: 'sellers#new_product_detail', as: 'new_product_detail'
        post '/product_details/', to: 'sellers#create_product_detail', as: 'create_product_detail'
        get '/product_details/:id', to: 'sellers#show_product_detail', as: 'show_product_detail'
        get '/product_details/:id/edit', to: 'sellers#edit_product_detail', as: 'edit_product_detail'
        put '/product_details/:id', to: 'sellers#update_product_detail', as: 'update_product_detail'
        delete '/product_details/:id', to: 'sellers#destroy_product_detail', as: 'destroy_product_detail'
      end
    end
    
    root to: "sellers#home", as: :seller_home
  end

  resources :clients do
    resources :transactions
  end

  get "/signup", to: "clients#new"
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  
  post '/products/', to: 'products#order', as: 'order_product'
  get '/products/:id', to: 'products#show', as: 'show_product'
  
  get '/get_price', to: 'clients#get_price'
  get '/shopping_cart', to: 'clients#shopping_cart'
  get '/enqueue_cart', to: 'clients#enqueue_cart'
  post '/add_to_shopping_cart/:product_id', to: 'clients#add_to_shopping_cart', as: 'add_to_shopping_cart'
  post '/add_to_enqueue_cart/:product_id', to: 'clients#add_to_enqueue_cart', as: 'add_to_enqueue_cart'
  post '/remove_from_shopping_cart/:product_id', to: 'clients#remove_from_shopping_cart', as: 'remove_from_shopping_cart'
  post '/remove_from_enqueue_cart/:product_id', to: 'clients#remove_from_enqueue_cart', as: 'remove_from_enqueue_cart'
  post '/checkout_cart/:product_id', to: 'clients#checkout_cart', as: 'checkout_cart'

  # Defines the root path route ("/")
  root "clients#products_list"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
