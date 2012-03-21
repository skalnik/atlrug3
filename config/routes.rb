ATLRUG::Application.routes.draw do
  resources :talks, :only => [:new, :create]

  match '/auth/:provider/callback', :to => 'sessions#create'

  root :to => 'high_voltage/pages#show', :id => 'home'
end
