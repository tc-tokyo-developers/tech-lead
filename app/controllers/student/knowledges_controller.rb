class Student::KnowledgesController < ApplicationController
  def index
    @knowledges = Knowledge.order('id ASC')
  end
  
  def show
    @knowledge = Knowledge.find(params[:id])
  end

end
