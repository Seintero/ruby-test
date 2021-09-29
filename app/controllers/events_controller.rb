# frozen_string_literal: true

require 'icalendar'

class EventsController < ApplicationController
  def index
    @events = ::Events::Filter.run!(params: events_params.to_hash)
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

  def search
    @events = ''
    @events = Event.search(params[:search], params[:page]) if params.key?('search') && !params[:search].empty?
  end

  def events_params
    params_list = [
      :page,
      :filter_date,
      :date_start,
      :city,
      :organizer,
      :reset,
      :submit
    ]
    params.permit(*params_list)
  end
end
