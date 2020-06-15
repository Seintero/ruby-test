class Admin::DashboardController < AdminController
  def index
    @organizer_number = Organizer.all.count
    @event_number = Event.all.count
  end
end