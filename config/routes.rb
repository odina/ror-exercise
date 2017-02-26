Rails.application.routes.draw do
  get 'welcome/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'welcome#index'

  match 'web_survey/:slug' => 'web_survey#new_response',
        as: :new_response,
        via: [:get]

  match 'web_survey/:slug' => 'web_survey#create_response',
        as: :create_response,
        via: [:post]

  match 'thank_you' => 'web_survey#thank_you',
        as: :thank_you,
        via: [:get]

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
