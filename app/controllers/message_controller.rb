class MessageController < ApplicationController
  
  def show
    @messages = Message.all
  end

end
