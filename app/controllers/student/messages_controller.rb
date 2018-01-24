class Student::MessagesController < ApplicationController
  def index
    @messages = Message.where(chat_group_params)
  end

  def create; end

  private

  def chat_group_params
    params.permit[:chat_group_id]
  end
end
