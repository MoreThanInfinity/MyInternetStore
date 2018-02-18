Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "home#index"
  get 'home/index'

  resources :users

  resources :comments do
    member do
      put 'like' => 'comments#vote'
    end
  end

  resources :items do
    member do
      put 'like' => 'items#vote'
    end
  end

  resources :orders do
    member do
      get 'replace' => 'orders#replace'
      put 'add_item' => 'orders#add_item'
      put 'delete_item' => 'orders#delete_item'
    end
  end

  resources :relations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
