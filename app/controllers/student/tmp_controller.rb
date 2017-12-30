class Student::TmpController < Student::BaseController
  skip_before_action :authenticate_student

  def index; end
end
