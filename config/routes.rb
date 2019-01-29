Rails.application.routes.draw do

  resources :homes, path: :home, only: [:index]

  get 'login', controller: :sessions, action: :new, as: :new_session
  post 'login', controller: :sessions, action: :create, as: :login
  delete 'logout', controller: :sessions, action: :destroy, as: :logout

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :show, :create]
    end
  end

  root to: 'homes#index'

end
