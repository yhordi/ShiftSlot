Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :venues, only: [:index, :show] do
    resources :shows
  end

  root 'venues#index'
end
