require 'test_helper'

class ApprovalRouteControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get approval_route_new_url
    assert_response :success
  end

  test "should get create" do
    get approval_route_create_url
    assert_response :success
  end

  test "should get edit" do
    get approval_route_edit_url
    assert_response :success
  end

  test "should get update" do
    get approval_route_update_url
    assert_response :success
  end

  test "should get show" do
    get approval_route_show_url
    assert_response :success
  end

  test "should get close_route" do
    get approval_route_close_route_url
    assert_response :success
  end

end
