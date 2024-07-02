# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/(:locale)', locale: /en|ru/ do
    root 'home#index'
    resources :posts

    scope module: :posts do
      resources :posts do
        resources :comments
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
