class Mentor::KnowledgesController < Mentor::BaseController
  skip_before_action :authenticate_mentor

  def index
    @knowledges = Knowledge.order('created_at desc')
  end

  def show
    @knowledge = Knowledge.find(params[:id])
  end

  def create
    Knowledge.create(knowledge_params)
  end

  def new
    @knowledge = Knowledge.new
  end

  def edit
    @knowledge = Knowledge.find(params[:id])
  end

  def update
    @knowledge = Knowledge.find(params[:id])
    @knowledge.updata(knowledge_params)
  end

  def destroy

  end

  private

  def knowledge_params
    params.require(:knowledge)
          .permit(:title, :content)
          .merge(user_id: current_mentor.id)
  end
end
