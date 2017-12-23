Rails.application.routes.draw do
  devise_for :user, :controllers => {:registrations => "user/registrations"}
  resources :venues, only: [:new, :create]

  devise_scope :user do
    get 'users/new', to: 'devise/registrations/new', controller: 'user/registrations', action: 'new', as: 'sign_up'
    post '/users', to: 'devise/registrations', controller: 'user/registrations', action: 'create'
    get '*org_name/login', param: :organization, controller: 'user/sessions', action: 'new'
    get 'login', controller: 'user/sessions', action: 'new'
    post 'sessions', to: 'devise/sessions', controller: 'user/sessions', action: 'create'
  end
  resources :organizations do
    get 'shows/' => 'shows#index', as: 'calendar'
    resources :shows, only: [:show, :new]
    resources :venues, only: [:index, :show], shallow: true do
      resources :shows, shallow: true do
        resources :shifts, except: :index
      end
    end
    post '/shows' => 'calendars#create'
    get '/sync' => 'calendars#sync'
    get '/callback' => 'omniauths#callback'
  end
  get '/redirect' => 'omniauths#redirect'
  post 'users/search', to: 'users#search'
  resources :users, only: [:edit, :show, :index, :update] do
    resources :assignments, only: [:new, :create]
    resources :preferred_days, only: [:update]
  end
  resources :assignments, only: :update
  root 'landings#index'
end
