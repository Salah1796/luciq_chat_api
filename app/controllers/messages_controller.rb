class MessagesController < ApplicationController
  before_action :set_chat

  # GET applications/{token}/chats/{number}/messages
  def index
    data = MessagesService.list(@chat, params[:application_token])
    render_success(data: data, message: "Messages retrieved successfully")
  end

  # GET applications/{token}/chats/{number}/messages/{number}
  def show
     data = MessagesService.find(@chat, params[:id])
     render_success(data: data, message: "Message retrieved successfully")
  end

   # POST applications/{token}/chats/{number}/messages
  def create
    
    return render_error(message: "body is missing", status: :bad_request) if params[:body].blank?
    data = MessagesService.create(@chat, params[:body],params[:application_token])
    render_success(data: data, message: "Message created successfully", status: :created)
  end

  # GET applications/{token}/chats/{number}/messages/search?q={someText}
  def search
     data = MessagesService.search(@chat, params[:q])
     render_success(data: data, message: "Search completed successfully")
     rescue => e
           Rails.logger.error("[MessagesController] Search error: #{e.message}")
           render_error(message: "Search failed", status: :internal_server_error)
  end

  private

  def set_chat
    app = Application.find_by!(token: params[:application_token])
    @chat = Chat.find_by!(application_id: app.id, number: params[:chat_number])
  end
end
