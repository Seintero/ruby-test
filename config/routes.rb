Rails.application.routes.draw do
  devise_for :admins
  root 'events#index'
  resources :events
end
