class UpdateCountersJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "🔄 Starting UpdateCountersJob"

    Application.find_each do |application|
      chats_count = Chat.where(application_id: application.id).count
      application.update(chats_count: chats_count)
    end

    Chat.find_each do |chat|
      messages_count = Message.where(chat_id: chat.id).count
      chat.update(messages_count: messages_count)
    end
    Rails.logger.info "✅ UpdateCountersJob finished"

    
  end

end
