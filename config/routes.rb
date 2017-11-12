Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :clients
    resources :projects
    resources :tasks
    resources :time_entries
  end

end
