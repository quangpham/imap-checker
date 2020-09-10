Rails.application.routes.draw do
  devise_for :users
  root to: "accounts#index"
  # devise_for :users

  resources :accounts do
    member do
      get 'check_mail'
    end
  end

  resources :mail_contents
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
