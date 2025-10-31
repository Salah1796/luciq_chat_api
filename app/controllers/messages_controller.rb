class MessagesController < ApplicationController
  before_action :set_chat

  def index
    messages = @chat.messages.order(:number).select(:number, :body, :created_at)
    render json: messages.map { |m| { number: m.number, body: m.body , created_at: m.created_at } }
  end

  def create
    redis_key = @chat.redis_messages_counter_key
    number = REDIS.incr(redis_key)
   Rails.logger.info "create message number=#{number} for chat with id =#{@chat.id}"
  
   PersistMessageJob.perform_later(@chat.id, number, params[:body])

    render json: { number: number }, status: :created
  end

  def search
    query = params[:q].to_s.strip
    return render json: [] if query.empty?

    results = Message.search_in_chat(@chat.id, query).records
    render json: results.map { |m| { number: m.number, body: m.body } }
  end

  private

  def set_chat
    app = Application.find_by!(token: params[:application_token])
    @chat = Chat.find_by!(application_id: app.id, number: params[:chat_number])
  end
end
