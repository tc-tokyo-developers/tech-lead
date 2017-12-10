Rails.application.routes.draw do
  namespace :mentor do
    get 'auth/:provider/callback' => 'sessions#callback'
    get 'logout' => 'sessions#destroy'
    resource :accounts, only: %i[show edit update]
    root 'tmp#index'
  end

  namespace :student, path: '' do
    get 'auth/:provider/callback' => 'sessions#callback'
    get 'logout' => 'sessions#destroy'
    resource :account, only: %i[show edit update]
  end

  root 'student/tmp#index'
end
