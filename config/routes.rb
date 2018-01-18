# == Route Map
#
#                Prefix Verb   URI Pattern                           Controller#Action
#     sessions_callback GET    /sessions/callback(.:format)          sessions#callback
#                       GET    /auth/:provider/callback(.:format)    sessions#callback
#         mentor_logout GET    /mentor/logout(.:format)              mentor/sessions#destroy
#   edit_mentor_account GET    /mentor/account/edit(.:format)        mentor/accounts#edit
#        mentor_account GET    /mentor/account(.:format)             mentor/accounts#show
#                       PATCH  /mentor/account(.:format)             mentor/accounts#update
#                       PUT    /mentor/account(.:format)             mentor/accounts#update
#     mentor_knowledges GET    /mentor/knowledges(.:format)          mentor/knowledges#index
#                       POST   /mentor/knowledges(.:format)          mentor/knowledges#create
#  new_mentor_knowledge GET    /mentor/knowledges/new(.:format)      mentor/knowledges#new
# edit_mentor_knowledge GET    /mentor/knowledges/:id/edit(.:format) mentor/knowledges#edit
#      mentor_knowledge GET    /mentor/knowledges/:id(.:format)      mentor/knowledges#show
#                       PATCH  /mentor/knowledges/:id(.:format)      mentor/knowledges#update
#                       PUT    /mentor/knowledges/:id(.:format)      mentor/knowledges#update
#                       DELETE /mentor/knowledges/:id(.:format)      mentor/knowledges#destroy
#           mentor_root GET    /mentor(.:format)                     mentor/tmp#index
#        student_logout GET    /logout(.:format)                     student/sessions#destroy
#  edit_student_account GET    /account/edit(.:format)               student/accounts#edit
#       student_account GET    /account(.:format)                    student/accounts#show
#                       PATCH  /account(.:format)                    student/accounts#update
#                       PUT    /account(.:format)                    student/accounts#update
#    student_knowledges GET    /knowledges(.:format)                 student/knowledges#index
#     student_knowledge GET    /knowledges/:id(.:format)             student/knowledges#show
#                  root GET    /                                     top#index
# 

Rails.application.routes.draw do
  get 'sessions/callback'

  get 'auth/:provider/callback' => 'sessions#callback'

  namespace :mentor do
    get 'logout' => 'sessions#destroy'
    resource :account, only: %i[show edit update]
    resources :knowledges
    root 'tmp#index'
  end

  namespace :student, path: '' do
    get 'logout' => 'sessions#destroy'
    resource :account, only: %i[show edit update]
    resources :knowledges, only: %i[index show]
  end

  root 'top#index'
end
