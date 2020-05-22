class EventsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :destroy, :update]

  def index
    @events = Event.paginate(:page => params[:page], :per_page => 9)
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
     if @event.save(validate: false)
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

  # todo: delete/edit, auth, pagination, filter

  private
  def event_params
    params.require(:event).permit(:title, :city, :location, :link, :event_date, :image, :description)
  end

end
