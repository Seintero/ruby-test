require 'test_helper'

class OrganizerTest < ActiveSupport::TestCase
  test "should not save organizer without name" do
    organizer = Organizer.new
    assert_not organizer.save, "Saved the organizer without a name"
  end
  test "should save organizer" do
    organizer = Organizer.new
    organizer.name = "RnD"
    assert organizer.save, "Not saved the organizer RnD"
  end
end
