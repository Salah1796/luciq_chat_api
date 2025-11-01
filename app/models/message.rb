class Message < ApplicationRecord
  belongs_to :chat
  validates :number, presence: true, uniqueness: { scope: :chat_id }
  validates :body, presence: true

   include Searchable
   SEARCHABLE_FIELDS = [:body, :chat_id, :number, :created_at, :updated_at]

   # Search messages in a specific chat with partial match
def self.search_messages(query, chat_id)
  return none unless chat_id.present?

  es_query = {
    bool: {
      must: query.present? ? [
        { wildcard: { body: "*#{query.downcase}*" } }
      ] : [],
      filter: [
        { term: { chat_id: chat_id } }
      ]
    }
  }

  __elasticsearch__.search(query: es_query, sort: { created_at: { order: 'asc' } }).records
end


end
