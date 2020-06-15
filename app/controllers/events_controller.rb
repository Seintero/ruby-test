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
  end
end
