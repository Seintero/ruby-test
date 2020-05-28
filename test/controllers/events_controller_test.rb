require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in admins(:user)
    @event = events(:testing_ruby_app)
  end

  test "should show event list page" do
    get events_path
    assert_select "h1", text: "Привет, мир!"
  end

  test "should show future event" do
    get events_path, params: { filter: "future" }
    assert_select ".card.mb-4.shadow-sm h3", "Testing Ruby App"
  end

   test "should show event detail page" do
     get  event_url(@event)
     assert_response :success, "does not show the event detail"

     assert_select "img.img-retina.img-fluid"
     assert_select "img[src$='test.png']"
     assert_select ".city", "Rostov-on-Don"
     assert_select ".organizer", "Test organizer1"
   end


   test "should destroy event" do
   assert_difference('Event.count', -1) do
     delete event_url(@event)
   end

   assert_redirected_to events_path, "does not redirect after remove event"
  end

   test "should update event" do
    patch event_url(@event), params: { event: { title: "updated" } }

    assert_redirected_to event_path(@event)
    @event.reload
    assert_equal "updated", @event.title, "does not update event name"
  end

  test "can create an event" do
    get "/events/new"
    assert_response :success

    post "/events",
         params: { event:{
                         title: "can create",
                         city: 'Moscow',
                         location: 'Earth',
                         link: 'http://test.test',
                         event_date: '2020.08.01 17:12:00',
                         organizer_id:  organizers(:one).id ,
                         image: fixture_file_upload("files/example.png", "image/png"),
                         description: 'test event'
                       }}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h2", "can create"
  end

end
