ATLRUG::Application.routes.draw do
  resources :talks, :only => [:new, :create]

  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/pages/*id" => 'pages#show', :as => :page, :format => false

  root :to => 'pages#show', :id => 'home'
end
