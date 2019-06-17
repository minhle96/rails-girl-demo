Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products do
    get :cms, on: :collection
  end

  resources :product_items, only: [:create, :delete, :destroy]
  post 'product_items/:id/add' => 'product_items#add_quantity', as: 'product_item_add'
  post 'product_items/:id/reduce' => 'product_items#reduce_quantity', as: 'product_item_reduce'
  resources :carts, only: [:show, :destroy]
end
