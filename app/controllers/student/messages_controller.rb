class Student::MessagesController < Student::BaseController
  def index
    @messages = Message.where(chat_group_id: current_student.id)
                       .includes(:user)
    @message = Message.new
  end
end
