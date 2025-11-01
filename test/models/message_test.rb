require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "should create message with valid number, body, and chat" do
    application = Application.create(name: "Test App")
    chat = Chat.create(number: 1, application: application)
    message = Message.new(number: 1, body: "Test message", chat: chat)
    assert message.save
  end

  test "should not create message without number" do
    application = Application.create(name: "Test App")
    chat = Chat.create(number: 1, application: application)
    message = Message.new(body: "Test message", chat: chat)
    assert_not message.save
  end

  test "should not create message without body" do
    application = Application.create(name: "Test App")
    chat = Chat.create(number: 1, application: application)
    message = Message.new(number: 1, chat: chat)
    assert_not message.save
  end

  test "should not create message without chat" do
    message = Message.new(number: 1, body: "Test message")
    assert_not message.save
  end
end