require 'test_helper'

class ReviewerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get reviewer_new_url
    assert_response :success
  end

  test "should get create" do
    get reviewer_create_url
    assert_response :success
  end

  test "should get destroy" do
    get reviewer_destroy_url
    assert_response :success
  end

end
