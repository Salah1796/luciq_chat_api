class ChatsService
  def self.list(application)
     cache_key = CHATS_LIST_CACHE_KEY.gsub("{token}", application.token)
     Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      Rails.logger.info "Reading chats from the database."
      application.chats.order(:number).pluck(:number, :messages_count).map do |number, messages_count|
      { number: number, messages_count: messages_count }
    end
    end.tap { |data| Rails.logger.info "Reading chats from the cache." if data }
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
