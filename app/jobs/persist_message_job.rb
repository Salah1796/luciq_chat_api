class PersistMessageJob < ApplicationJob
  retry_on StandardError, wait: 10.seconds, attempts: 5
  queue_as :default

  def perform(chat_id, number, body)
    start_time = Time.current
    Rails.logger.info "🔔 PersistMessageJob started at #{start_time} | chat_id=#{chat_id}, number=#{number}"

    chat = Chat.find_by(id: chat_id)
    unless chat
      Rails.logger.warn "⚠️ Chat not found: id=#{chat_id}"
      return
    end

    sql = ActiveRecord::Base.send(
      :sanitize_sql_array,
      [
        "INSERT IGNORE INTO messages (chat_id, number, body, created_at, updated_at) VALUES (?, ?, ?, NOW(), NOW())",
        chat.id,
        number,
        body
      ]
    )

    Chat.connection.execute(sql)

    end_time = Time.current
    Rails.logger.info "✅ PersistMessageJob finished at #{end_time} | chat_id=#{chat_id}, number=#{number} (elapsed #{end_time - start_time} sec)"

  rescue ActiveRecord::RecordNotUnique => e
    Rails.logger.warn "⚠️ Duplicate Message: chat_id=#{chat_id}, number=#{number} (#{e.message})"
  rescue StandardError => e
    Rails.logger.error "💥 Error in PersistMessageJob: chat_id=#{chat_id}, number=#{number} | #{e.message}"
    raise
  end
end
