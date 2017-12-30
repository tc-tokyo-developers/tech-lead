Rails.application.routes.draw do
<<<<<<< HEAD
  get 'sessions/callback'

  get 'auth/:provider/callback' => 'sessions#callback'

  namespace :mentor do
    get 'logout' => 'sessions#destroy'
    resource :account, only: %i[show edit update]
    root 'tmp#index'
  end

  namespace :student, path: '' do
    get 'logout' => 'sessions#destroy'
    resource :account, only: %i[show edit update]
  end

<<<<<<< HEAD
  root 'student/tmp#index'
=======
  root "top#index"
>>>>>>> 029be6f... Create top_controller
=======
  root 'top#index'
>>>>>>> 0508d75... modify header styles
end
