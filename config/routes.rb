Rails.application.routes.draw do
  get 'welcome/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'welcome#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
