Findit::Application.routes.draw do
  devise_for :users
  root :to=>"items#index", :type=>"Desktop"
  resources :users, :except => [:new, :create]
  resources :allowed_users, :only => :create
  resources :comments
  resources :areas, :except =>[:show]
  resources :projects, :except => [:show]
  resources :tickets do
    collection do
      post 'take'
      get 'show_by_area'
      get 'show_by_project'
    end
  end
  resources :operating_systems, :except => [:show]
  resources :dns_names
  resources :softwares
  resources :locations, :except => [:show]
  resources :buildings, :except => [:show]
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

  resources :labels, only: [:show]

  resources :ips, :except => [:show]
  resources :pages
  resources :installations do
    collection do
      post 'install_software'
      get 'uninstall_software'
    end
  end
end
