Rails.application.routes.draw do
  root 'home#index'
  get 'form', to: 'home#form'
  post 'search', to: 'home#search'
  post 'autocomplete', to: 'home#autocomplete'
end
