require 'test_helper'

class ApproverControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get approver_new_url
    assert_response :success
  end

  test "should get create" do
    get approver_create_url
    assert_response :success
  end

  test "should get destroy" do
    get approver_destroy_url
    assert_response :success
  end

end
