require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = events(:testing_ruby_app)
  end

  test "should not save empty event" do
    event = Event.new
    assert_not event.save, "Saved empty event"
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "title should be present" do
    @event.title = " "
    assert_not @event.valid?
  end

  test "title should be more characters" do
    @event.title = "a" * 3
    assert_not @event.valid?
  end

  test "city should be present" do
    @event.city = " "
    assert_not @event.valid?
  end

  test "location should be present" do
    @event.location = " "
    assert_not @event.valid?
  end

  test "organizer should be present" do
    @event.organizer = nil
    assert_not @event.valid?
  end

  test "event_date should be present" do
    @event.event_date = ' '
    assert_not @event.valid?
  end

  test "event_date format" do
    @event.event_date = 'test', 'event_date must be in format DD-MM-YYYY hh:mm'
    assert_not @event.valid?
  end

  test "link format" do
    @event.link = 'www.test.ru', 'link must be in url format http://...'
    assert_not @event.valid?
  end

end
