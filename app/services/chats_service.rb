class ChatsService
  def self.list(application)
    application.chats.order(:number).pluck(:number, :messages_count).map do |number, messages_count|
      { number: number, messages_count: messages_count }
    end
  end

  def self.find(application, number)
    chat = application.chats.find_by!(number: number)
    { number: chat.number, messages_count: chat.messages_count }
  end

  def self.create(application)
    redis_key = application.redis_chats_counter_key
    number = REDIS.incr(redis_key)
    PersistChatJob.perform_later(application.id, number)
    { number: number, messages_count: 0 }
  end
end
