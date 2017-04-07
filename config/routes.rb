Rails.application.routes.draw do
  get 'admin/edit_user'
  get 'admin/edit_order'

  resources :posts
  devise_for :users
  get 'pages/about'

  get 'pages/contact'

  resources :sites
  resources :orders
  get 'purchases' => "orders#purchases"
  get 'allposts' => "posts#posts"
  get 'allusers' => "posts#users"


  root 'sites#index' 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
