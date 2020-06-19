Rails.application.routes.draw do

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  match "/403", :to => "errors#forbidden_error", :via => :all

  devise_for :admins

  root 'events#index'
  resources :organizers
  resources :subscribers, only: :create
  resources :events do
    get 'search', on: :collection
  end

  namespace :admin do
    resource :dashboard, only: :index
    root to: 'dashboard#index'
    resources :organizers, :events
  end
end
