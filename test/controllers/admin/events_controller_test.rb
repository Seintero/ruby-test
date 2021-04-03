# frozen_string_literal: true

require 'test_helper'

module Admin
  class EventsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
      sign_in admins(:user)
      @event = events(:testing_ruby_app)
    end

    test 'should show event list page' do
      get admin_events_path
      assert_select 'h3', text: 'Список событий'
    end

    test 'should show event detail page' do
      get admin_event_url(@event)
      assert_response :success, 'does not show the event detail'

      assert_select 'img.img-retina.img-fluid'
      assert_select "img[src$='test.png']"
      assert_select 'b:contains("Город") + span', 'Rostov-on-Don'
      assert_select 'b:contains("Организатор") + span', 'Test organizer1'
    end

    test 'should destroy event' do
      assert_difference('Event.count', -1) do
        delete admin_event_url(@event)
      end

      assert_redirected_to admin_events_path, 'does not redirect after remove event'
    end

    test 'should update event' do
      patch admin_event_url(@event), params: { event: { title: 'updated' } }

      assert_redirected_to admin_event_path(@event)
      @event.reload
      assert_equal 'updated', @event.title, 'does not update event name'
    end

    test 'can create an event' do
      get '/admin/events/new'
      assert_response :success

      post '/admin/events',
           params: { event: {
             title: 'can create',
             city: 'Moscow',
             location: 'Earth',
             link: 'http://test.test',
             event_date: '2020.08.01 17:12:00',
             organizer_id: organizers(:one).id,
             image: fixture_file_upload('files/example.png', 'image/png'),
             description: 'test event'
           } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select 'b:contains("Наименование") + span', 'can create'
    end
  end
end
