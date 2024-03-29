Rails.application.routes.draw do
  root to: "home#index"

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: "users/callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/me' => "users#me"
      get '/following' => "users#following"
    end
  end

   mount ActionCable.server => '/cable'
end
