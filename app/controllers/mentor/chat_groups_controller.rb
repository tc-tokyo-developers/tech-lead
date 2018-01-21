class Mentor::ChatGroupsController < ApplicationController
  def index
    @chat_groups = Student.all
  end
end
