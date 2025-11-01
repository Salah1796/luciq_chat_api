class PersistApplicationJob < ApplicationJob
  queue_as :default

  def perform(name, token)
    Application.create!(name: name, token: token)
  end
end