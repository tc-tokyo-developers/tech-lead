Rails.application.routes.draw do
  namespace :student, path: '' do
    get 'auth/:provider/callback' => 'sessions#callback'
    get 'logout' => 'sessions#destroy'
  end
end
