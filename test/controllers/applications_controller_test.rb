require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @application = Application.create(name: "Test App", token: "test_token")
  end

  test "should get index" do
    get applications_url, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response["success"]
    assert_not_nil json_response["data"]
    assert json_response["data"].any? { |app| app["name"] == @application.name }
    assert json_response["data"].any? { |app| app["token"] == @application.token }
  end

  test "should create application" do
    post applications_url, params: { name: "New App" }, as: :json
    assert_response :created
    json_response = JSON.parse(response.body)
    assert json_response["success"]
    assert_equal "New App", json_response["data"]["name"]
    assert_not_nil json_response["data"]["token"]
    assert_equal 0, json_response["data"]["chats_count"]
  end

  test "should show application" do
    get application_url(@application.token), as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response["success"]
    assert_equal @application.name, json_response["data"]["name"]
    assert_equal @application.token, json_response["data"]["token"]
    assert_equal 0, json_response["data"]["chats_count"]
  end

  test "should update application" do
    patch application_url(@application.token), params: { name: "Updated App" }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response["success"]
    assert_equal "Updated App", json_response["data"]["name"]
    assert_equal @application.token, json_response["data"]["token"]
  end
end
