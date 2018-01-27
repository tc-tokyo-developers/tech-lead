class Mentor::KnowledgesController < Mentor::BaseController
  skip_before_action :authenticate_mentor
  PAGE = 3

  def index
    @knowledges = Knowledge.page(params[:page]).per(PAGE)
  end

  def show
    @knowledge = Knowledge.find(params[:id])
  end

  def create
    @knowledge = Knowledge.new
    if params[:commit] == 'ajax'
      render text: ajax_action
    else
      Knowledge.create(knowledge_params)
    end
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

  def destroy; end

  private

  def ajax_action
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(params.require(:knowledge)[:content]).html_safe
  end

  def knowledge_params
    params.require(:knowledge)
          .permit(:title, :content)
          .merge(user_id: current_mentor.id)
  end
end
