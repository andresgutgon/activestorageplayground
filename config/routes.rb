Rails.application.routes.draw do
  scope module: 'account' do
    get 'signup', to: 'registrations#new'
    post 'signup', to: 'registrations#create'

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create', as: 'log_in'
    delete 'logout', to: 'sessions#destroy'
    resource :profile, only: %i[edit update] do
      member do
        put 'delete_avatar'
      end
    end
  end

  # Resolve polimorphic single resource like gallery
  # Helpful to use form_with @gallery and let Rails generate
  # the right URLs
  resolve("Gallery") { [:gallery] }
  scope module: 'my_gallery' do
    resource :gallery, only: %i[show create update] do
      collection do
        delete :delete_image_attachment
      end
    end
  end

  root 'my_gallery/galleries#show'
end
