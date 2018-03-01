class ChatGroupsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_groups_#{params[:chat_group_id]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def post(data)
    message = Message.new(
      content: data['content'],
      chat_group_id: data['chat_group_id'],
      user_id: current_user_id
    )
    # TODO: エラー処理
    message.save!
    MessageBroadcastJob.perform_later(message, data['user_type'])
  end
end
