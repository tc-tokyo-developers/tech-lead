class Mentor::KnowledgesController < Mentor::BaseController
  skip_before_action :authenticate_mentor

  def index

  end

  def show

  end

  def create
    Knowledge.create(knowledge_params)
  end

  def new; end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def knowledge_params
    params.permit(:title, :content).merge(user_id: current_mentor.id)
  end
end
