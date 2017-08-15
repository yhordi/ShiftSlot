Rails.application.routes.draw do
  devise_for :users
  resources :venues, only: [:index, :show] do
    resources :shows, only: :show
    resources :shows, shallow: true do
      resources :shifts, only: [:new, :create, :update, :destroy, :edit]
    end
  end

  post 'users/search', to: 'users#search'

  resources :users, only: [:edit, :show, :index, :update] do

    resources :preferred_days, only: [:create] do
      collection do
        put 'update_all'
      end
    end
  end
  root 'landings#index'
end
