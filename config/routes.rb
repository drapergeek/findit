Findit::Application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :allowed_users, only: :create
  resources :areas, except: [:show]
  resources :buildings, except: [:show]
  resources :comments
  resources :dns_names

  resources :items do
    collection do
      get "not_checked"
      post "add_ip"
      get "remove_ip"
      get "remove_dns_name"
      get "mark_as_inventoried"
      get "surplus"
    end
  end

  resources :installations do
    collection do
      post "install_software"
      get "uninstall_software"
    end
  end

  resources :ips, except: [:show]
  resources :item_types, only: [:index, :create, :destroy]
  resources :labels, only: [:show]
  resources :locations, except: [:show]
  resources :operating_systems, except: [:show]
  resources :pages
  resources :projects, except: [:show]
  resources :softwares

  resources :tickets do
    collection do
      post "take"
      get "show_by_area"
      get "show_by_project"
    end
  end

  resources :users

  namespace :api do
    resources :items, only: [:index, :show]
  end
end
