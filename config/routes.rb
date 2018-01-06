Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :clients
    
    resources :projects

    resources :tasks

    get 'time_entries/current', to: 'time_entries#current'
    resources :time_entries 
  end

end
