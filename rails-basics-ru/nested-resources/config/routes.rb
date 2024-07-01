# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  resources :posts, shallow: true do
    resources :post_comments, only: %i[edit create update destroy]
  end
end
