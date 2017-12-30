class Mentor::TmpController < Mentor::BaseController
  skip_before_action :authenticate_mentor

  def index; end
end
