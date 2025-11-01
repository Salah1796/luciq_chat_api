class Application < ApplicationRecord
  has_many :chats, dependent: :destroy

  before_create :generate_token

  validates :name, presence: true

  validates :token, uniqueness: true

   def redis_chats_counter_key
    "#{id}_chats_counter"
  end

  private

  def generate_token
    self.token ||= SecureRandom.hex(16)
  end
end

