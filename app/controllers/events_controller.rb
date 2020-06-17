require 'icalendar'

class EventsController < ApplicationController
  def index
    @events = Event.all
    sql_params = []
    conditions = []

    if params.has_key?("filter_date") && !params[:filter_date].empty?
      if (params[:filter_date] == "last")
        conditions << ["event_date < ?"]
      elsif (params[:filter_date] == "future")
        conditions << ["event_date > ?"]
      end
      sql_params << DateTime.now
    end

    if params.has_key?("city") && !params[:city].empty?
      conditions << ["city LIKE ?"]
      sql_params << "%" + params[:city] + "%"
    end

    if params.has_key?("date_start") && !params[:date_start].empty?
      conditions << ["DATE(event_date) = ?"]
      sql_params << Time.parse(params[:date_start]).strftime('%Y/%m/%d')

    end

    @events = @events.where(conditions.join(' AND '), *sql_params)

    if params.has_key?("organizer") && !params[:organizer].empty?
      @events = @events.joins(:organizer).where('organizers.name LIKE ?', "%" + params[:organizer] + "%")
    end

    @events = @events.order("event_date DESC").paginate(:page => params[:page], :per_page => 9)

    respond_to do |format|
      format.js { render partial: 'filter' }
      format.html { render :index }
    end

  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@event.to_ics)
        calendar.publish
        render plain: calendar.to_ical
      end
    end
  end

end
