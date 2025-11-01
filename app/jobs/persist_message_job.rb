class PersistMessageJob < ApplicationJob
  retry_on StandardError, wait: 10.seconds, attempts: 5
  queue_as :default

  def perform(chat_id, number, body,token)
    start_time = Time.current
    Rails.logger.info "🔔 PersistMessageJob started at #{start_time} | chat_id=#{chat_id}, number=#{number}"

    chat = Chat.find_by(id: chat_id)
    unless chat
      Rails.logger.warn "⚠️ Chat not found: id=#{chat_id}"
      return
    end

     message = Message.find_or_create_by!(
      chat_id: chat.id,
      number: number,
      body: body
    )
     cache_key = Messages_LIST_CACHE_KEY.gsub("{token}", token).gsub("{number}", chat.number.to_s)
     Rails.cache.delete(cache_key)
    
    begin
      message.__elasticsearch__.index_document
      Rails.logger.info("✅  Message indexed in Elasticsearch: #{message.id}")
    rescue => e
      Rails.logger.error("💥 Failed to index message #{message.id}: #{e.message}")
    end

    end_time = Time.current
    Rails.logger.info "✅ PersistMessageJob finished at #{end_time} | chat_id=#{chat_id}, number=#{number} (elapsed #{end_time - start_time} sec)"

  rescue ActiveRecord::RecordNotUnique => e
    Rails.logger.warn "⚠️ Duplicate Message: chat_id=#{chat_id}, number=#{number} (#{e.message})"
  rescue StandardError => e
    Rails.logger.error "💥 Error in PersistMessageJob: chat_id=#{chat_id}, number=#{number} | #{e.message}"
    raise
  end
end
