class MessagesService
  def self.list(chat)
    chat.messages.order(:number).pluck(:number, :body, :created_at).map do |number, body, created_at|
      { number: number, body: body, created_at: created_at }
    end
  end

  def self.find(chat, number)
    message = chat.messages.find_by!(number: number)
    { number: message.number, body: message.body, created_at: message.created_at }
  end

  def self.create(chat, body)
    raise ArgumentError, "Body is missing" if body.blank?

    redis_key = chat.redis_messages_counter_key
    number = REDIS.incr(redis_key)
    PersistMessageJob.perform_later(chat.id, number, body)

    { number: number, body: body }
  end

  def self.search(chat, query)
    results = Message.search_messages(query, chat.id)
    results.map { |m| { number: m.number, body: m.body, created_at: m.created_at } }
  rescue => e
    Rails.logger.error("[MessagesService] Search error: #{e.message}")
    raise StandardError, "Search failed"
  end
end
