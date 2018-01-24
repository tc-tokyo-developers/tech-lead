class Mentor::MessagesController < Mentor::BaseController
  def create
    @message = Message.new(message_params)
    @message.save!
    redirect_to mentor_chat_group_path(params[:chat_group_id]),
                notice: '投稿が完了しました'
  end

  private

  def message_params
    params.require(:message)
          .permit(:content)
          .merge(chat_group_id: params[:chat_group_id])
          .merge(user_id: current_mentor.id)
  end
end
