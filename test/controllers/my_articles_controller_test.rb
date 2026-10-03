
require "test_helper"

class MyArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    post user_session_url, params: {
      user: {
        email: user.email,
        password: "password123"
      }
    }

    get my_articles_url
    assert_response :success
  end
end
