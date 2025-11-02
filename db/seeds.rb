require 'securerandom'

# Create 12 applications with 10 chats each, and 10 messages per chat
12.times do |i|
  app_name = "Chat App #{i + 1}"
  application = Application.create!(name: app_name)
  puts "Created Application: #{application.name} with token: #{application.token}"

  10.times do |j|
    chat_number = j + 1
    chat = application.chats.create!(number: chat_number)
    puts "  Created Chat number: #{chat.number} for Application: #{application.name}"

    10.times do |k|
      message_body = "Message #{k + 1} in Chat #{chat_number} of #{app_name}."
      chat.messages.create!(number: k + 1, body: message_body)
    end
    puts "    Created 10 messages for Chat number: #{chat.number}"
  end
end
