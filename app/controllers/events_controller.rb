# frozen_string_literal: true

require 'icalendar'

class EventsController < ApplicationController
  def index
    @events = Event.main_filter(params)
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
    @events = if params.key?('search') && !params[:search].empty?
                Event.search(params[:search], params[:page])
              else
                ''
              end
  end
end
