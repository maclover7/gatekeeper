Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end

  namespace :api do
    get "/users/me" => "users#me"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
