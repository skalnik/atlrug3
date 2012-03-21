ATLRUG::Application.routes.draw do
  resources :talks, :only => [:new, :create]

  root :to => "talks#new"
end
