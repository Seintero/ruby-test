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
      flash[:success] = "Организатор успешно создан"
      redirect_to [:admin, @organizer]
    else
      flash[:danger] = "Во время создания произошла ошибка"
      render "new"
    end
  end

  def update
    @organizer = Organizer.find(params[:id])
    if @organizer.update(organizer_params)
      flash[:success] = "Организатор успешно изменён"
      redirect_to [:admin, @organizer]
    else
      flash[:danger] = "Во время редактирования произошла ошибка"
      render 'edit'
    end
  end

  def destroy
    @organizer = Organizer.find(params[:id])
    if @organizer.destroy
      flash[:success] = "Организатор успешно удалён"
    else
      flash[:success] = "Во время удаления произошла ошибка"
    end
    redirect_to admin_organizers_path
  end

  private

  def organizer_params
    params.require(:organizer).permit(:name, :description)
  end
end
