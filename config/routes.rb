Rails.application.routes.draw do
  root 'home#index'
  get 'form', to: 'home#form'
  post 'search', to: 'home#search'
  post 'autocomplete', to: 'home#autocomplete'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect_to('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
end
