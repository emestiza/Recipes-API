Rails.application.routes.draw do
  resources :category do
    resources :recipe
  end

  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
