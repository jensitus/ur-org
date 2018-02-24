require 'test_helper'

class CustomAppearancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get custom_appearances_index_url
    assert_response :success
  end

  test "should get edit" do
    get custom_appearances_edit_url
    assert_response :success
  end

  test "should get new" do
    get custom_appearances_new_url
    assert_response :success
  end

  test "should get create" do
    get custom_appearances_create_url
    assert_response :success
  end

  test "should get update" do
    get custom_appearances_update_url
    assert_response :success
  end

  test "should get show" do
    get custom_appearances_show_url
    assert_response :success
  end

end
