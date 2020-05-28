require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "should not save empty event" do
    event = Event.new
    assert_not event.save, "Saved empty event"
  end
end
