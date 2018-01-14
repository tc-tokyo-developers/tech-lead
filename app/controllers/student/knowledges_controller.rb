class Student::KnowledgesController < ApplicationController
  def index
    @knowledges = Knowledge.all
  end
  def show
  end
end
