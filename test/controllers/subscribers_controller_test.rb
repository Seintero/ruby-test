require 'test_helper'

class SubscribersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @subscriber = subscribers(:one)
  end

  test "new subscribe" do
    assert_emails 1 do
      post subscribers_path, params: {subscriber: {email: ENV['TEST_EMAIL']}}, as: :json
    end
    message = JSON.parse(@response.body)
    assert_equal "success", message['status'], "does not sign a new address"
  end

  test "do not add add existing email" do
    post subscribers_path, params: {subscriber: {email: @subscriber.email}}, as: :json
    message = JSON.parse(@response.body)
    assert_equal "error", message['status'], "add existing address"
  end
end
