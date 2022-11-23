Rails.application.routes.draw do
  get 'maps/index'
  get 'posts/index'
  get    '/',                               to: 'users#top'
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
