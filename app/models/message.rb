class Message < ApplicationRecord
  belongs_to :chat
  validates :number, presence: true, uniqueness: { scope: :chat_id }
  validates :body, presence: true

   include Searchable
   SEARCHABLE_FIELDS = [:body, :chat_id, :number, :created_at, :updated_at]

  def self.search_messages(query, chat_id)
   return none unless chat_id.present?
   __elasticsearch__.search(query: {
    bool: {
      must: query.present? ? { match: { body: query } } : { match_all: {} },
      filter: [
        { term: { chat_id: chat_id } }
      ]
    }
   }, sort: { created_at: { order: 'asc' } }).records
  end
 
end
