class Admin::OrganizersController < AdminController

  def index
    @organizers = Organizer.paginate(:page => params[:page], :per_page => 9)
  end

  def show
    @organizer = Organizer.find(params[:id])
  end

  def new
    @organizer = Organizer.new
  end

  def edit
    @organizer = Organizer.find(params[:id])
  end

  def create
    @organizer = Organizer.new(organizer_params)
    if @organizer.save
      redirect_to [:admin, @organizer], notice: 'organizer success'
    else
      render "new"
    end
  end

  def update
    @organizer = Organizer.find(params[:id])
    if @organizer.update(organizer_params)
      redirect_to [:admin, @organizer]
    else
      render 'edit'
    end
  end

  def destroy
    @organizer = Organizer.find(params[:id])
    @organizer.destroy
    redirect_to admin_organizers_path
  end

  private
  def organizer_params
    params.require(:organizer).permit(:name)
  end

end
