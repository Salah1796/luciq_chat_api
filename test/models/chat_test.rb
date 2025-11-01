require "test_helper"

class ChatTest < ActiveSupport::TestCase
  test "should create chat with valid number and application" do
    application = Application.create(name: "Test App")
    chat = Chat.new(number: 1, application: application)
    assert chat.save
    assert_equal 1, chat.number
    assert_equal application.id, chat.application_id
    assert_equal 0, chat.messages_count
  end

  test "should not create chat without number" do
    application = Application.create(name: "Test App")
    chat = Chat.new(application: application)
    assert_not chat.save
  end

  test "should not create chat without application" do
    chat = Chat.new(number: 1)
    assert_not chat.save
  end
end