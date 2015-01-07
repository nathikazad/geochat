Rails.application.routes.draw do

  apipie
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications, :authorizations
  end
  namespace :api do
    namespace :v1 do
      get     'user/chat_rooms',            to: 'users#chat_rooms',             format: 'json'
      get     'user',                       to: 'users#show',                   format: 'json'
      patch   'user',                       to: 'users#update',                 format: 'json'
      patch   'user/connected',             to: 'users#update_connected',       format: 'json'
      delete  'user',                       to: 'user#destroy',                 format: 'json'
      get     'chat_rooms',                 to: 'chat_rooms#index',             format: 'json'
      post    'chat_rooms/create',          to: 'chat_rooms#create',            format: 'json'
      post    'chat_room/add_user',         to: 'chat_rooms#add_user',          format: 'json'
      delete  'chat_room/remove_user',      to: 'chat_rooms#remove_user',       format: 'json'
      post    'chat_room/send_message',     to: 'chat_rooms#send_message',      format: 'json'
      get     'chat_room/retrieve_messages',to: 'chat_rooms#retrieve_messages', format: 'json'
      get     'chat_room',                  to: 'chat_rooms#show',              format: 'json'
      patch   'chat_room',                  to: 'chat_rooms#update',            format: 'json'
      delete  'chat_room',                  to: 'chat_rooms#destroy',           format: 'json'
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
