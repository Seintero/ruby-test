class Admin::EventsController < AdminController
  def index
      @events = Event.order("event_date DESC").paginate(:page => params[:page], :per_page => 9)
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
      redirect_to [:admin, @event], notice: 'event success'
     else
       render "new"
     end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to  [:admin, @event]
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to admin_events_path
  end

  private
  def event_params
    params.require(:event).permit(:title, :city, :location, :link, :event_date, :image, :description, :organizer_id)
  end

end
