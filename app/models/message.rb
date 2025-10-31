class Message < ApplicationRecord
  belongs_to :chat, counter_cache: :messages_count

  validates :number, presence: true,
                     uniqueness: { scope: :chat_id }

  validates :body, presence: true

  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # settings do
  #   mappings dynamic: false do
  #     indexes :body, type: :text, analyzer: :english
  #     indexes :chat_id, type: :integer
  #     indexes :number, type: :integer
  #   end
  # end

  def self.search_in_chat(chat_id, query)
    # search({
    #   query: {
    #     bool: {
    #       must: [
    #         { match: { body: query } },
    #         { term: { chat_id: chat_id } }
    #       ]
    #     }
    #   }
    # })
  end
end
