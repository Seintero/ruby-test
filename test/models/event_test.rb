# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = events(:testing_ruby_app)
  end

  test 'should not save empty event' do
    event = Event.new
    assert_not event.save, 'Saved empty event'
  end

  test 'should be valid' do
    assert @event.valid?
  end

  test 'title should be present' do
    @event.title = ' '
    assert_not @event.valid?
  end

  test 'title should be more characters' do
    @event.title = 'a' * 3
    assert_not @event.valid?
  end

  test 'city should be present' do
    @event.city = ' '
    assert_not @event.valid?
  end

  test 'image should be present' do
    @event.image = nil
    assert_not @event.valid?
  end

  test 'location should be present' do
    @event.location = ' '
    assert_not @event.valid?
  end

  test 'organizer should be present' do
    @event.organizer = nil
    assert_not @event.valid?
  end

  test 'event_date should be present' do
    @event.event_date = ' '
    assert_not @event.valid?
  end

  test 'event_date format' do
    @event.event_date = 'test', 'event_date must be in format DD-MM-YYYY hh:mm'
    assert_not @event.valid?
  end

  test 'link format' do
    @event.link = 'www.test.ru', 'link must be in url format http://...'
    assert_not @event.valid?
  end

  test 'find by date' do
    event = Event.find_by_date(@event.event_date)
    assert_not event.empty?, 'Not find by full event date'

    date_formats = %w[%d-%m-%Y %d.%m.%Y %Y.%m.%d %Y-%m-%d]
    date_formats.each do |date_format|
      event = Event.find_by_date(@event.event_date.strftime(date_format))
      assert_not event.empty?, "Should find by event date in #{date_format}"
    end
  end

  test 'should work main_filter' do
    event = Event.main_filter({ filter_date_future: 'future' })
    assert_not event.empty?, 'Not find future event in main_filter'

    @organizer = organizers(:one)
    event = Event.main_filter({ organizer: @organizer.name })
    assert_not event.empty?, 'Should find in main_filter by organizer name'

    event = Event.main_filter({ city: @event.city })
    assert_not event.empty?, 'Should find in main_filter by city'

    date_formats = %w[%d-%m-%Y %d.%m.%Y %Y.%m.%d]
    date_formats.each do |date_format|
      event = Event.main_filter({ date_start: @event.event_date.strftime(date_format) })
      assert_not event.empty?, "Should find in main_filter by event_date in #{date_format}"
    end
  end

  test 'should search' do
    event = Event.search(@event.title)
    assert_not event.empty?, 'Not find in date format %d-%m-%Y'
  end
end
