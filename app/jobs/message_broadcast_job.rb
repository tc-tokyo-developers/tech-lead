class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # TODO: right or leftの判定を綺麗にする
  def perform(message, user_type)
    ActionCable.server.broadcast(
      "chat_groups_#{message.chat_group_id}_channel",
      right_message: render_message(message, 'right'),
      left_message: render_message(message, 'left'),
      user_type: user_type
    )
  end

  private

  def render_message(message, side)
    ApplicationController.render(
      partial: 'shared/message',
      locals: { message: message, side: side }
    )
  end
end
