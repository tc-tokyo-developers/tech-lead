class Student::KnowledgesController < ApplicationController
  def index
    @knowledges = Knowledge.order('id ASC')
  end
  
  def show
    @knowledge = Knowledge.find(params[:id])
  end

  private

  def knowledge_params
    params.require(:knowledge)
        .permit(:title, :content)
        .merge(user_id: current_mentor.id)
  end
end
