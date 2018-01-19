Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :clients, defaults: {format: 'json'}
    
    resources :projects, defaults: {format: 'json'}

    resources :tasks, defaults: {format: 'json'}

    get 'time_entries/current', to: 'time_entries#current'
    resources :time_entries, defaults: {format: 'json'}

    get 'summaries/workload', to: 'summaries#workload_chart'
  end

end
