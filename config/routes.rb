Rails.application.routes.draw do
  Healthcheck.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#main'

  resources :people
end
