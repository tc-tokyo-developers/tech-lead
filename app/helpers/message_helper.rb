module MessageHelper
  def same_user_type?(message)
    (defined?(current_mentor) && message.user.type_id == 'mentor') ||
      (defined?(current_student) && current_student&.id == message.user_id)
  end
end
