Helpdesk::Application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.

  devise_for :superadmins,:controllers => {
    :confirmations => 'superadmin_confirmations',
    :invitations => 'superadmin_invitations'
  }, :path => '/admin', :path_names => {:sign_in => 'admin_login',:sign_up => 'register'}

  devise_scope :superadmin do
    patch "/superadmins/confirm" => "superadmin_confirmations#confirm", :as => :superadmin_confirm
  end
  
  devise_for :agents, :controllers => {
    :confirmations => 'agent_confirmations',
    :invitations => 'agent_invitations',
    :registrations => 'agents/registrations'
  }, :path => '', :path_names => {:sign_in => 'login', :sign_up => 'register'}
             
  devise_scope :agent do
    patch "/agents/confirm" => "agent_confirmations#confirm", :as => :agent_confirm
    get '/agents' => "agent_invitations#index"
  end

  scope "/manage" do
    resources :agents, :only => [:edit,:update,:destroy], :as => "manage_agent"
  end
  
  resources :companies, :except => [:show, :index]
  resources :subscriptions, :except => [:show, :destroy]
  resources :plans, :except => [:destroy], :path => "plans"
  resources :tickets, :path => "tickets"
  resources :labels, :except => [:show], :path => "labels"
  resources :groups,:except => [:show], :path => "groups"
  resources :filters,:except => [:show]
  resources :snippets,:except => [:show]
  resources :notifications,:except => [:show,:index,:new,:create,:destroy]
  resources :forwarding_addresses,:except => [:show]

  get '/admin',  to: "admin#index"
  post '/messages', to: "tickets#messages"

  scope '/reports' do
    ReportsController.action_methods.each do |action|
      match "/#{action}", to: "reports##{action}", via: [:get, :post], as: "reports_#{action}"
    end
  end

  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  authenticated :agent do
    root to: "tickets#index", as: :agents_root
  end

  authenticated :superadmin do
    # superadmin's root
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  MainController.action_methods.each do |action|
    get "/#{action}", to: "main##{action}"
  end

  root 'main#index'

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
