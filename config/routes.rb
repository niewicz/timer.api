Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :clients, defaults: {format: 'json'}
    
    resources :projects, defaults: {format: 'json'}

    resources :tasks, defaults: {format: 'json'}

    get 'time_entries/current', to: 'time_entries#current'
    get 'time_entries/grouped', to: 'time_entries#index_grouped'
    resources :time_entries, defaults: {format: 'json'}

    get 'summaries/workload', to: 'summaries#workload_chart'
    get 'summaries/last_projects', to: 'summaries#last_projects'
  end

end
