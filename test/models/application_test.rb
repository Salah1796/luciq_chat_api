require "test_helper"

class ApplicationTest < ActiveSupport::TestCase
  test "should create application with valid name" do
    application = Application.new(name: "Test App")
    assert application.save
    assert_not_nil application.token
    assert_equal "Test App", application.name
    assert_equal 0, application.chats_count
    assert_equal 32, application.token.length
  end

  test "should not create application without name" do
    application = Application.new
    assert_not application.save
  end

  test "should generate unique token on creation" do
    application = Application.create!(name: "Test App")
    assert_not_nil application.token
    assert_equal 32, application.token.length
  end

  test "chats_count should default to 0" do
    application = Application.create!(name: "Test App")
    assert_equal 0, application.chats_count
  end

  test "redis_chats_counter_key should return correct key" do
    application = Application.create!(name: "Test App")
    expected_key = "#{application.id}_chats_counter"
    assert_equal expected_key, application.redis_chats_counter_key
  end

  test "generate_token should not overwrite existing token" do 
    application = Application.new(name: "Test App", token: "existing_token")
    application.send(:generate_token)
    assert_equal "existing_token", application.token
  end
end