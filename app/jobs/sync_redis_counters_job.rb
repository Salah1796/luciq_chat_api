class SyncRedisCountersJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "🔄 Starting SyncRedisCountersJob"

    Application.find_each do |app|

      redis_chats_key = app.redis_chats_counter_key
      max_chat_number = app.chats.maximum(:number) || 0
      current_redis_number = REDIS.get(redis_chats_key).to_i
      if current_redis_number != max_chat_number
        REDIS.set(redis_chats_key, max_chat_number)
        Rails.logger.info "✅ Redis chats counter synced: app=#{app.token}, number=#{max_chat_number}"
      end

      app.chats.find_each do |chat|
        redis_messages_key = chat.redis_messages_counter_key
        max_message_number = chat.messages.maximum(:number) || 0
        current_msg_redis = REDIS.get(redis_messages_key).to_i

        if current_msg_redis != max_message_number
          REDIS.set(redis_messages_key, max_message_number)
          Rails.logger.info "✅ Redis messages counter synced: app=#{app.token}, chat=#{chat.number}, number=#{max_message_number}"
        end
      end
    end
  end
end