Rails.application.routes.draw do
  root  :to => 'top#top'
  get    'maps/index'
  get    'posts/index'
  post   'guest_login',                     to: 'guest_sessions#create'
  post   '/search',                         to: 'search#search'
  get    '/login',                          to: 'sessions#new'
  post   '/login',                          to: 'sessions#create'
  delete '/logout',                         to: 'sessions#destroy'
  get    '/users/account',                  to: 'users#account'
  get    '/users/profile',                  to: 'users#profile'
  post   '/users/profile_update',           to: 'users#profile_update'
  get    '/users/edit',                     to: 'users#edit'
  post   '/users/update',                   to: 'users#update'
  get    '/posts/:id/index',                to: 'posts#edit_index'

  resources :users
  resources :posts
  resources :maps, only: [:show]
end
