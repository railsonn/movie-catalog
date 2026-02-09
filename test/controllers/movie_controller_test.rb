require "test_helper"

class MovieControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movie_index_url
    assert_response :success
  end

  test "should get create" do
    get movie_create_url
    assert_response :success
  end

  test "should get destroy" do
    get movie_destroy_url
    assert_response :success
  end

  test "should get update" do
    get movie_update_url
    assert_response :success
  end

  test "should get show" do
    get movie_show_url
    assert_response :success
  end

  test "should get new" do
    get movie_new_url
    assert_response :success
  end

  test "should get edit" do
    get movie_edit_url
    assert_response :success
  end
end
