Rails.application.routes.draw do

  resources :homes, path: :home, only: [:index, :update]

  get 'login', controller: :sessions, action: :new, as: :new_session
  post 'login', controller: :sessions, action: :create, as: :login
  delete 'logout', controller: :sessions, action: :destroy, as: :logout

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :show, :create]
      namespace :reports do
        resources :by_authors, path: :by_author, only: [:create]
      end
    end
  end

  root to: 'homes#index'

end
