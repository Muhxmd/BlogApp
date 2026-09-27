require "test_helper"

class MyArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_articles_index_url
    assert_response :success
  end
end
