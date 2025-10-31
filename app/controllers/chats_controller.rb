class ChatsController < ApplicationController
  before_action :set_application

   # GET /applications/:application_token/chats
  def index
    chats = @application.chats.order(:number).select(:number, :messages_count)
    render json: chats.map { |c| { number: c.number, messages_count: c.messages_count } }
  end

  
 # POST /applications/:application_token/chats
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
