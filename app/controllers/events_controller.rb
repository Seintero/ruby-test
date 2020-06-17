require 'icalendar'

class EventsController < ApplicationController
  # todo:  filter
  def index
    if params.has_key?("filter")
      if (params[:filter]=="last")
        @events = Event.where("event_date < ?", DateTime.now).order("event_date DESC").paginate(:page => params[:page], :per_page => 9)
      elsif (params[:filter]=="future")
        @events = Event.where("event_date > ?", DateTime.now).order("event_date DESC").paginate(:page => params[:page], :per_page => 9)
      end
      @filter = params[:filter]
    else
      @events = Event.order("event_date DESC").paginate(:page => params[:page], :per_page => 9)
    end
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |wants|
      wants.html
      wants.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@event.to_ics)
        calendar.publish
        render plain: calendar.to_ical
      end
    end
  end
end
