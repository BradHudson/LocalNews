Rails.application.routes.draw do
  root 'home#index'
  get 'form', to: 'home#form'
end
