require 'test_helper'

class OrganizerTest < ActiveSupport::TestCase
  def setup
    @organizer = organizers(:one)
  end

  test "should not save organizer without name" do
    organizer = Organizer.new
    assert_not organizer.save, "Saved the organizer without a name"
  end

  test "should save organizer" do
    organizer = Organizer.new
    organizer.name = "RnD"
    assert organizer.save, "Not saved the organizer RnD"
  end

  test "organizer should be unique" do
    duplicate = @organizer.dup
    duplicate.save
    assert_not duplicate.valid?
  end

  test "name should be unique in uppercase" do
    duplicate = @organizer.dup
    duplicate.name = @organizer.name.upcase
    @organizer.save
    assert_not duplicate.valid?
  end

  test "description more then 255 characters" do
    @organizer.description = "a" * 256
    assert_not @organizer.valid?
  end
end
