require 'test_helper'

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in admins(:user)
  end

  test "should get index" do
    get '/admin'
    assert_response :success
  end
end
