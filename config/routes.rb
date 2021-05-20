Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get 'auth/google_oauth2/callback', to: 'sessions#GoogleAuth'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show'

  resources :reports, only: [:index, :show]
  
  namespace :google_sheets do
    resources :reports, only: [:index] do 
      resource :download, only: [:show]
    end
  end 
  
end
