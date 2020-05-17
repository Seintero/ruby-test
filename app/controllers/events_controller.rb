class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
     @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
     if @event.save(validate: false)
      redirect_to @event, notice: 'event success'
     else
       render "new"
     end
  end

  def destroy
    @event = Event.find(paramd[:id])
    @event.destroy
    redirect_to events_path
  end

  # todo: delete/edit, auth, pagination, filter

  private
  def event_params
    params.require(:event).permit(:title, :city, :location, :link, :event_date, :description)
  end

end
