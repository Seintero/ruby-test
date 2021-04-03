# frozen_string_literal: true

require 'test_helper'

module Admin
  class DashboardControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
      sign_in administrators(:user)
    end

    test 'should get index' do
      get '/admin'
      assert_response :success
    end
  end
end
