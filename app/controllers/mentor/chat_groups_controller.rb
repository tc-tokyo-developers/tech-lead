class Mentor::ChatGroupsController < ApplicationController
  def index
    @chat_groups = ChatGroup.all
  end

  def show
    @chat_group_ids = ChatGroup.pluck(:id)
    @chat_group = ChatGroup.find_by(chat_group_params)
    @messages = Message.where(chat_group_params)
    @message = Message.new
  end

  private

  def chat_group_params
    params.permit(:chat_group_id, :content)
  end
end
