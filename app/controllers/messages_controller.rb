class MessagesController < ApplicationController
  before_action :set_chat

  # GET applications/{token}/chats/{number}/messages
  def index
    messages = @chat.messages.order(:number).pluck(:number, :body, :created_at)
    render json: messages.map { |number, body, created_at| { number: number, body: body, created_at: created_at } }
  end

  # GET applications/{token}/chats/{number}/messages/{number}
  def show
     message = @chat.messages.find_by!(number: params[:id])
     render json: { number: message.number, body: message.body, created_at: message.created_at }
  end

   # POST applications/{token}/chats/{number}/messages
  def create
    return render json: { error: 'body is missing' }, status: :bad_request if params[:body].blank?

    redis_key = @chat.redis_messages_counter_key
    number = REDIS.incr(redis_key)
    PersistMessageJob.perform_later(@chat.id, number, params[:body])
    render json: { number: number }, status: :created
  end

  # GET applications/{token}/chats/{number}/messages/search?q={someText}
  def search
     query = params[:q].to_s.strip

    results = Message.search_messages(query, @chat.id)

    render json: results.map { |m| { number: m.number, body: m.body, created_at: m.created_at } }
    rescue => e
           Rails.logger.error("[MessagesController] Search error: #{e.message}")
           render json: { error: "Search failed" }, status: :internal_server_error
  end

  private

  def set_chat
    app = Application.find_by!(token: params[:application_token])
    @chat = Chat.find_by!(application_id: app.id, number: params[:chat_number])
  end
end
