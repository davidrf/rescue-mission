Rails.application.routes.draw do
  root 'questions#index'
  resources :questions do
    resources :answers, only: [:create, :update]
  end

  resource :session, only: [:new, :create, :destroy] do
    get "failure", on: :member
  end

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
end
