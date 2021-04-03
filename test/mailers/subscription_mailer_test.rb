# frozen_string_literal: true

require 'test_helper'

class SubscriptionMailerTest < ActionMailer::TestCase
  test 'invite' do
    email = SubscriptionMailer.with(email: ENV['TEST_EMAIL']).welcome_email
    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [ENV['SMTP_USERNAME']], email.from
    assert_equal [ENV['TEST_EMAIL']], email.to
    assert_equal 'Welcome to My Awesome Site', email.subject
    assert_equal read_fixture('invite').join, email.text_part.body.decoded
  end
end
