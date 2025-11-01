class Chat < ApplicationRecord
  belongs_to :application

  has_many :messages, dependent: :destroy

  validates :number, presence: true,
                     uniqueness: { scope: :application_id }

  validates :application_id, presence: true


   def redis_messages_counter_key
    "#{application.id}_#{id}_messages_counter"
  end
end
