require 'test_helper'

class CreatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get creators_index_url
    assert_response :success
  end

  test "should get edit" do
    get creators_edit_url
    assert_response :success
  end

  test "should get update" do
    get creators_update_url
    assert_response :success
  end

  test "should get destroy" do
    get creators_destroy_url
    assert_response :success
  end

end
