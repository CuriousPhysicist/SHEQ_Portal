require 'test_helper'

class DocumentControllerTest < ActionDispatch::IntegrationTest
  test "should get resources" do
    get document_resources_url
    assert_response :success
  end

  test "should get index" do
    get document_index_url
    assert_response :success
  end

  test "should get new" do
    get document_new_url
    assert_response :success
  end

  test "should get create" do
    get document_create_url
    assert_response :success
  end

  test "should get edit" do
    get document_edit_url
    assert_response :success
  end

  test "should get update" do
    get document_update_url
    assert_response :success
  end

  test "should get show" do
    get document_show_url
    assert_response :success
  end

  test "should get import" do
    get document_import_url
    assert_response :success
  end

  test "should get search" do
    get document_search_url
    assert_response :success
  end

  test "should get tasks" do
    get document_tasks_url
    assert_response :success
  end

  test "should get reviewplease" do
    get document_reviewplease_url
    assert_response :success
  end

  test "should get reviewed" do
    get document_reviewed_url
    assert_response :success
  end

  test "should get approveplease" do
    get document_approveplease_url
    assert_response :success
  end

  test "should get approved" do
    get document_approved_url
    assert_response :success
  end

  test "should get checkout" do
    get document_checkout_url
    assert_response :success
  end

  test "should get checkin" do
    get document_checkin_url
    assert_response :success
  end

end
