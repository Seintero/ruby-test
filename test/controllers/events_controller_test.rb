require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @event = events(:testing_ruby_app)
  end

  test "should show event list page" do
    get events_path
    assert_select "h1", text: "Привет, мир!"
  end

  test "should show future event" do
    get events_path, params: { filter_date_future: "future" }
    assert_select ".card.shadow-sm h3", "Testing Ruby App"
  end

   test "should show event detail page" do
     get  event_url(@event)
     assert_response :success, "does not show the event detail"

     assert_select "img.img-retina.img-fluid"
     assert_select "img[src$='test.png']"
     assert_select ".city", "Rostov-on-Don"
     assert_select ".organizer", "Test organizer1"
   end

  test "not show event in admin" do
    get admin_event_url(@event)
    assert_redirected_to new_admin_session_url ,  "Open admin area for unauthorized user"
  end
end
