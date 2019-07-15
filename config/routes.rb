# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  namespace :admin do
    resources :contributors
    resources :developers
    resources :packages
    resources :versions
    resources :authors
    resources :maintainers

    mount Sidekiq::Web => '/sidekiq'

    root to: 'contributors#index'
  end
end
