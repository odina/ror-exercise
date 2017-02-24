Rails.application.routes.draw do
  get 'welcome/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'welcome#index'

  # resources :answers
  # resources :responses
  # resources :questions
  # resources :web_surveys
  # resources :users

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
