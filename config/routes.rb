Findit::Application.routes.draw do
  resources :comments

  resources :areas
  resources :projects
  resources :tickets
  resources :operating_systems
  resources :dns_names
  resources :softwares
  resources :locations
  resources :buildings
  resources :items do 
    collection do
      get 'not_checked'
      post 'add_ip'
      get 'remove_ip'
      get 'remove_dns_name' 
      get 'mark_as_inventoried'
      get 'surplus'
    end
  end
  resources :reports, :only=>:index do
    collection do
      get :dns
      get :proc_ratings
      get :upgrades
    end
  end
  resources :ips
  resources :pages
  resources :users do  
    collection do 
      get 'logout'
    end
  end
  resources :installations do
    collection do
      post 'install_software'
      get 'uninstall_software'
    end
  end
  resources :announcements
  resources :incoming_email, :only=>[:index]
  match "mail", :to=>"incoming_email#index", :as=>"mail"
  root :to=>"items#index", :type=>"Desktop"
  match "/auth/cas/callback"=>"sessions#create"
  match "logout", :to=>"sessions#destroy", :as=> "logout"
  match "admin", :to=>"admin#index", :as=> "admin"
  end
