class ChatsController < ApplicationController
  before_action :set_application

   # GET /applications/{token}/chats
  def index
    chats = @application.chats.order(:number).pluck(:number, :messages_count)
    render json: chats.map { |number, messages_count| { number: number, messages_count: messages_count } }
  end

  # GET /applications/{token}/chats/{number}
   def show
     chat = @application.chats.find_by!(number: params[:number])
     render json: { number: chat.number, messages_count: chat.messages_count }
  end
  
 # POST /applications/{token}/chats
  def create
    redis_key = @application.redis_chats_counter_key

    number = REDIS.incr(redis_key)

    PersistChatJob.perform_later(@application.id, number)

    render json: { number: number, messages_count: 0 }, status: :created
  end

  private

  def set_application
    @application = Application.find_by!(token: params[:application_token])
  end
end
