# frozen_string_literal: true

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @event = events(:testing_ruby_app)
  end

  test 'should show event list page' do
    get events_path
    assert_select 'h1', text: 'Привет, мир!'
  end

  test 'working filter' do
    get events_path, params: { filter_date_future: 'future' }
    assert_select '.card.shadow-sm h3', @event.title, 'should show future event'

    @organizer = organizers(:one)
    get events_path, params: { organizer: @organizer.name }
    assert_select '.card.shadow-sm h3', @event.title, 'should filter event by organizer name'

    get events_path, params: { city: @event.city }
    assert_select '.card.shadow-sm .d-flex  + .card-text', /#{@event.city}/, 'should filter event by city'

    get events_path, params: { date_start: @event.event_date.strftime('%d.%m.%Y') }
    assert_select '.card.shadow-sm .d-flex .card-text.mr-3', @event.event_date.strftime('%d.%m.%Y')
  end

  test 'search event' do
    get search_events_path, params: { search: @event.title }
    assert_select '.card.shadow-sm h3', @event.title, 'should search event by name'
  end

  test 'should show event detail page' do
    get event_url(@event)
    assert_response :success, 'does not show the event detail'

    assert_select 'img.img-retina.img-fluid'
    assert_select "img[src$='test.png']"
    assert_select '.city', 'Rostov-on-Don'
    assert_select '.organizer', 'Test organizer1'
  end

  test 'not show event in admin' do
    get admin_event_url(@event)
    assert_redirected_to new_administrator_session_url, 'Open admin area for unauthorized user'
  end
end
