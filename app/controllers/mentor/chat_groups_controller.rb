class Mentor::ChatGroupsController < Mentor::BaseController
  before_action :set_chat_groups, only: %i[index show]

  def index; end

  def show
    @chat_group = ChatGroup.find(params[:id])
    @messages = @chat_group.messages.includes(:user)
    @message = Message.new
  rescue ActiveRecord::RecordNotFound
    redirect_to mentor_chat_groups_path
  end

  private

  def set_chat_groups
    # TODO: SQL発行しまくるのでどうにかする
    @chat_groups = ChatGroup.all_with_latest_message
  end
end
