# == Route Map
#
#               Prefix Verb  URI Pattern                        Controller#Action
#    sessions_callback GET   /sessions/callback(.:format)       sessions#callback
#                      GET   /auth/:provider/callback(.:format) sessions#callback
#        mentor_logout GET   /mentor/logout(.:format)           mentor/sessions#destroy
#  edit_mentor_account GET   /mentor/account/edit(.:format)     mentor/accounts#edit
#       mentor_account GET   /mentor/account(.:format)          mentor/accounts#show
#                      PATCH /mentor/account(.:format)          mentor/accounts#update
#                      PUT   /mentor/account(.:format)          mentor/accounts#update
#          mentor_root GET   /mentor(.:format)                  mentor/tmp#index
#       student_logout GET   /logout(.:format)                  student/sessions#destroy
# edit_student_account GET   /account/edit(.:format)            student/accounts#edit
#      student_account GET   /account(.:format)                 student/accounts#show
#                      PATCH /account(.:format)                 student/accounts#update
#                      PUT   /account(.:format)                 student/accounts#update
#             messages GET   /messages(.:format)                messages#index
#                      POST  /messages(.:format)                messages#create
#                 root GET   /                                  top#index
#                      GET   /messages(.:format)                messeges#show
# 

Rails.application.routes.draw do
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

  resources :messages, only: [:index, :create]

  root 'top#index'

  get 'messages' => 'messeges#show'
end
