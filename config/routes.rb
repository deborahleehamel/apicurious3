Rails.application.routes.draw do
  root to: "welcome#home"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"
  get "/:username", to: 'users#show', as: :user
  delete "/logout", to: 'sessions#destroy', as: :logout

  resources :users, only: [:show]
end
