Rails.application.routes.draw do
  devise_for :users
  resources :organizations, only: [:new, :create, :show]
  resources :venues, only: [:index, :show] do
    resources :shows, only: :show
    resources :shows, shallow: true do
      resources :shifts, only: [:new, :create, :update, :destroy, :edit]
    end
  end
  get 'shows/' => 'shows#index', as: 'calendar'

  post 'users/search', to: 'users#search'

  resources :users, only: [:edit, :show, :index, :update] do
    resources :preferred_days, only: [:update]
  end
  root 'landings#index'
  post '/shows' => 'calendars#create'
  get '/sync' => 'calendars#sync'
  get '/callback' => 'omniauths#callback'
  get '/redirect' => 'omniauths#redirect'
end
