Rails.application.routes.draw do
  namespace :student, path: '' do
    get 'tmp/index'
    get 'auth/:provider/callback' => 'sessions#callback'
    get 'logout' => 'sessions#destroy'
  end

  root 'tmp#Index'
end
