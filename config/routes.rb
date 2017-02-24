Rails.application.routes.draw do
  get 'welcome/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'welcome#index'

  resources :web_surveys, param: :slug

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
