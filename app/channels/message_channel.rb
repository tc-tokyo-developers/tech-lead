class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'message_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def post(data)
    message = Message.new(
      content: data['content'],
      chat_group_id: data['chat_group_id'],
      user_id: data['user_id']
    )
    # TODO: エラー処理
    message.save!
    MessageBroadcastJob.perform_later(message, data['user_type'])
  end
end
