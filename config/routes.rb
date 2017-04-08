Rails.application.routes.draw do
  get 'chatroom_users/create'

  get 'chatroom_users/destroy'

  resources :chatrooms do
    resource :chatroom_users
    resource :messages
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "chatrooms#index"
end
