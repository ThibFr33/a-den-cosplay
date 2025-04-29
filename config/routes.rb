# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'home', to: 'pages#home', as: :home
  get 'about', to: 'pages#about', as: :about
  resources :members
  resources :events, only: [:index]
  resources :contact_form, only: %i[new create]

  # Defines the root path route ("/")
  root 'pages#home'
end
