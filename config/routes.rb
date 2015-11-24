Rails.application.routes.draw do
  resource :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :goals

  resources :goal_comments, only: [:new, :create, :destroy]
  resources :user_comments, only: [:new, :create, :destroy]
end
