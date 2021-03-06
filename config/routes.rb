Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :events do
    resources :attendees, :controller => "event_attendees"
    resource :location, :controller => "event_locations"

    collection do
      get :latest

      post :bulk_update
    end

    member do
      get :dashboard

      post :join
      post :withdraw
    end
  end

  namespace :admin do
    resources :events
  end

  resources :people

  get "/welcome/say_hello" => "welcome#say"

  get "/welcome" => "welcome#index"
  get "/something" => "welcome#something"

  get "/ubike" => "welcome#ubike"

  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
    resources :events

    post "login" => "auth#login"
    post "logout" => "auth#logout"
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # resources :events do
  #   resources :attendees, shallow: true
  # end
  # => 等同於下列
  # resources :enevts do
  #   resources :attendees, only: [:index, :new, :create]
  # end
  # resources :attendees, only: [:show, :edit, :update, :destroy]

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

  #外卡路由就不再使用了
  #match ':controller(/:action(/:id(.:format)))', :via => :all
end
