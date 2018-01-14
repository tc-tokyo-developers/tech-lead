class Mentor::KnowledgesController < Mentor::BaseController
  def index

  end
  def show

  end
  def create
    Knowledge.create(strong_params)
  end
  def new; end
  def edit

  end
  def update

  end
  def destroy

  end

  def strong_params
    params.permit(:title, :content).merge(user_id: current_mentor.id)
  end
end
