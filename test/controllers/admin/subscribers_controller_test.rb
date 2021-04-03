# frozen_string_literal: true

require 'test_helper'

module Admin
  class SubscribersControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
      sign_in administrators(:user)
      @subscriber = subscribers(:one)
    end

    test 'should destroy subscriber' do
      assert_difference('Subscriber.count', -1) do
        delete admin_subscriber_url(@subscriber)
      end

      assert_redirected_to admin_subscribers_path, 'does not redirect after remove organizer'
    end

    test 'should update subscriber' do
      puts(@subscriber.active)
      patch admin_subscriber_url(@subscriber), params: { subscriber: { active: false } }

      assert_redirected_to admin_subscribers_url, 'does not redirect after update subscriber'

      puts(@subscriber.active)
      @subscriber.reload
      assert_equal false, @subscriber.active, 'does not update subscriber status'
    end
  end
end
