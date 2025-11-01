require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @application = Application.create(name: "Test App", token: "test_token")
  end

  test "should get index" do
    get applications_url, as: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert body.any? { |app| app["name"] == @application.name }
    assert body.any? { |app| app["token"] == @application.token }
    assert body.any? { |app| app["chats_count"] == 0 }
  end

  test "should create application" do
    post applications_url, params: { name: "New App" }, as: :json
    assert_response :created
    body = JSON.parse(response.body)
    assert body["name"] == "New App"
    assert body["token"] != nil
    assert body["chats_count"] == 0
  end

  test "should show application" do
    get application_url(@application.token), as: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert body["name"] == @application.name
    assert body["token"] == @application.token
    assert body["chats_count"] == 0 
  end

  test "should update application" do
    patch application_url(@application.token), params: { name: "Updated App" }, as: :json
    assert_response :success
    get application_url(@application.token), as: :json
    body = JSON.parse(response.body)
    assert body["name"] == "Updated App"
    assert body["token"] == @application.token
    assert body["chats_count"] == 0
  end
end
