class UpdateCountersJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "🔄 Starting UpdateCountersJob"

    Application.connection.execute("UPDATE applications a SET a.chats_count = (SELECT COUNT(*) FROM chats c WHERE c.application_id = a.id)")

    Chat.connection.execute("UPDATE chats c SET c.messages_count = (SELECT COUNT(*) FROM messages m WHERE m.chat_id = c.id)")
    Rails.logger.info "✅ UpdateCountersJob finished"

    
  end

end
