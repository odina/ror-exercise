Rails.application.routes.draw do
  get 'welcome/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'welcome#index'


  match 'web_survey/:slug' => 'web_survey#answer',
        as: :answer_web_survey,
        via: [:get, :post]

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
