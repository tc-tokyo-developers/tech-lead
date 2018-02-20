class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # TODO: right or leftの判定を綺麗にする
  def perform(message, user_type)
    ActionCable.server.broadcast(
      "chat_groups_#{message.chat_group_id}_channel",
      right_message: render_right_message(message),
      left_message: render_left_message(message),
      user_type: user_type
    )
  end

  private

  def render_right_message(message)
    ApplicationController.renderer.render(
      partial: 'shared/message', locals: { message: message, right: true }
    )
  end

  def render_left_message(message)
    ApplicationController.renderer.render(
      partial: 'shared/message', locals: { message: message, left: true }
    )
  end
end
