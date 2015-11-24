Rails.application.routes.draw do
  resource :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :goals
end
