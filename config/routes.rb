Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Almost every application defines a route for the root path ("/") at the top of this file.
  # root "articles#index"
  scope module: 'account' do
    get 'signup', to: 'registrations#new'
    post 'signup', to: 'registrations#create'

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create', as: 'log_in'
    delete 'logout', to: 'sessions#destroy'
    resource :profiles, only: %i[update]
  end

  root 'main#index'
end
