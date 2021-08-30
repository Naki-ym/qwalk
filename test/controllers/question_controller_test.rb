require "test_helper"

class QuestionControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get question_top_url
    assert_response :success
  end
end
