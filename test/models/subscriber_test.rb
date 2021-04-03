# frozen_string_literal: true

require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase
  def setup
    @subscriber = subscribers(:one)
  end

  test 'should be valid' do
    assert @subscriber.valid?
  end

  test 'should not save empty' do
    subscriber = Subscriber.new
    assert_not subscriber.save, 'Saved empty subscriber'
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[test@test,com test___test__test.org test.name@test.
                           test@test___test.com test@test+test.com]
    invalid_addresses.each do |invalid_address|
      @subscriber.email = invalid_address
      assert_not @subscriber.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate = @subscriber.dup
    @subscriber.save
    assert_not duplicate.valid?
  end

  test 'email addresses should be unique in uppercase' do
    duplicate = @subscriber.dup
    duplicate.email = @subscriber.email.upcase
    @subscriber.save
    assert_not duplicate.valid?
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Test@ExAMPle.rU'
    @subscriber.email = mixed_case_email
    @subscriber.save
    assert_equal mixed_case_email.downcase, @subscriber.reload.email
  end
end
