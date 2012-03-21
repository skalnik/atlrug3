ATLRUG::Application.routes.draw do
  resources :talks, :only => [:new, :create]

  match '/auth/:provider/callback', :to => 'sessions#create'

  root :to => "talks#new"
end
