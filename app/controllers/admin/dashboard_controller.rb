# frozen_string_literal: true

module Admin
  class DashboardController < AdminController
    def index
      @organizer_number = Organizer.all.count
      @event_number = Event.all.count
    end
  end
end
