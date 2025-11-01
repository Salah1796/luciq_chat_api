class PersistApplicationJob < ApplicationJob
  queue_as :default

  def perform(name, token)
    Application.create!(name: name, token: token)
    Rails.cache.delete(APPLICATION_LIST_CACHE_KEY)
  end
end