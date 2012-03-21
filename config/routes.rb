ATLRUG::Application.routes.draw do
  resources :talks, :only => [:new, :create]
end
