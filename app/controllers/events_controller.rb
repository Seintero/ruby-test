class EventsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :destroy, :update]

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

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
     if @event.save
      redirect_to @event, notice: 'event success'
     else
       render "new"
     end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private
  def event_params
    params.require(:event).permit(:title, :city, :location, :link, :event_date, :image, :description, :organizer_id)
  end

end
