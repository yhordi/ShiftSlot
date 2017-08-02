Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :venues, only: [:index, :show] do
    resources :shows
  end

  resources :users, only: [:edit, :show, :index, :update]
  root 'landings#index'
end
