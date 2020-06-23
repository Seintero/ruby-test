require 'test_helper'

class SubscribersControllerTest < ActionDispatch::IntegrationTest
  test "new subscribe" do
    assert_emails 1 do
      post subscribers_path, params: { subscriber: { email: ENV['TEST_EMAIL']} }, as: :json
    end
  end
end
