ATLRUG::Application.routes.draw do
  resources :talks, :only => [:new, :create]

  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/pages/*id" => 'pages#show', :as => :page, :format => false
  match '/login' => redirect('/auth/github'), :as => :login
  match '/log_out' => 'sessions#destroy', :as => :log_out

  root :to => 'pages#show', :id => 'home'
end
