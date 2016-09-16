Rails.application.routes.draw do
  root 'home#index'
  get 'form', to: 'home#form'
  post 'autocomplete', to: 'home#autocomplete'
end
