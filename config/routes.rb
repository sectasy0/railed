# frozen_string_literal: true

Rails.application.routes.draw do
  get :health, controller: 'health', action: :show, as: :rails_health_check

  devise_for :accounts, controllers: {
    registrations: 'accounts/registrations',
    sessions: 'accounts/sessions',
    omniauth_callbacks: 'accounts/omniauth_callbacks'
  }, skip: [:passwords]

  mount LetterOpenerWeb::Engine, at: '/letters' if Rails.env.development?

  # only for current_account
  namespace :accounts, path: '' do
    namespace :passwords, path: '/me/password' do
      get :edit
      patch :update
    end
    namespace :passwords_reset, path: '/password' do
      get :new, path: '/forgot', as: :password_forgot
      post :create, path: '/reset', as: :password_reset
      get :edit
      patch :update
    end
  end

  get '/language/:locale' => 'home#change_locale', as: :change_locale

  get '/contact', to: 'landing#contact'
  post '/contact/send', to: 'landing#send_message'

  namespace :dashboard do
    resources :home, only: :index, path: ''
    resources :servers, only: %i[new create update destroy]
    resources :website, only: %i[new create] do
      patch :update, on: :collection
    end
  end

  root 'landing#index'
end
