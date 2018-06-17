Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    post 'clients/:id/send_report', to: 'clients#send_report'
    resources :clients, defaults: {format: 'json'}
    
    resources :projects, defaults: {format: 'json'}

    resources :tasks, defaults: {format: 'json'}

    get 'time_entries/current', to: 'time_entries#current'
    get 'time_entries/grouped', to: 'time_entries#index_grouped'
    resources :time_entries, defaults: {format: 'json'}

    get 'summaries/workload', to: 'summaries#workload_chart'
    get 'summaries/last_projects', to: 'summaries#last_projects'

    get 'users/current', to: 'users#show'
    put 'users/update_billing_profile', to: 'users#update_billing_profile'
    put 'users/current/set_timezone', to: 'users#set_timezone'
  end

end
