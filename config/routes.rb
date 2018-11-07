Rails.application.routes.draw do
  root   'users#index'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    resources :interviews do
      put 'confirm', on: :member
    end
    resource :account_resets, only: [:edit, :update]
  end
  resources :interviews do
    post 'check_date', on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
