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
#   mentor_chat_groups GET   /mentor/chat_groups(.:format)      mentor/chat_groups#index
#    mentor_chat_group GET   /mentor/chat_groups/:id(.:format)  mentor/chat_groups#show
#          mentor_root GET   /mentor(.:format)                  mentor/tmp#index
#       student_logout GET   /logout(.:format)                  student/sessions#destroy
# edit_student_account GET   /account/edit(.:format)            student/accounts#edit
#      student_account GET   /account(.:format)                 student/accounts#show
#                      PATCH /account(.:format)                 student/accounts#update
#                      PUT   /account(.:format)                 student/accounts#update
#     student_messages GET   /chat(.:format)                    student/messages#index
#         student_root GET   /                                  student/tmp#index
#                            /cable                             #<ActionCable::Server::Base:0x00007fc80cb38608 @mutex=#<Monitor:0x00007fc80cb385e0 @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x00007fc80cb38590>>, @pubsub=nil, @worker_pool=nil, @event_loop=nil, @remote_connections=nil>
#                 root GET   /                                  top#index
# 

Rails.application.routes.draw do
  get 'sessions/callback'

  get 'auth/:provider/callback' => 'sessions#callback'

  namespace :mentor do
    get 'logout' => 'sessions#destroy'
    resource :account, only: %i[show edit update]
    resources :chat_groups, only: %i[index show]
    root 'tmp#index'
  end

  namespace :student, path: '' do
    get 'logout' => 'sessions#destroy'
    resource :account, only: %i[show edit update]
    resources :messages, path: 'chat', only: :index
    root 'tmp#index'
  end

  mount ActionCable.server => '/cable'
  root 'top#index'
end
