Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:create, :destroy, :new]
  resources :goals, except: [:index]
end
