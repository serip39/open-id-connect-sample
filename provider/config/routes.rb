Rails.application.routes.draw do
  use_doorkeeper_openid_connect
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "doorkeeper/applications#index"
end
