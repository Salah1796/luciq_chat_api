class ChatsController < ApplicationController
  before_action :set_application

   # GET /applications/{token}/chats
  def index
    data = ChatsService.list(@application)
    render_success(data: data, message: "Chats retrieved successfully")
  end

  # GET /applications/{token}/chats/{number}
   def show
     data = ChatsService.find(@application, params[:number])
     render_success(data: data, message: "Chat retrieved successfully")
  end
  
 # POST /applications/{token}/chats
  def create
    data = ChatsService.create(@application)
    render_success(data: data, message: "Chat created successfully", status: :created) # This was already correct, but good to confirm.
  end

  private

  def set_application
    @application = Application.find_by!(token: params[:application_token])
  end
end
