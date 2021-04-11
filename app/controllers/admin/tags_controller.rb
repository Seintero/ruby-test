# frozen_string_literal: true

module Admin
  class TagsController < AdminController
    def index
      @tags = Tag.paginate(page: params[:page], per_page: 9)
    end

    def show
      @tag = Tag.find(params[:id])
    end

    def new
      @tag = Tag.new
    end

    def edit
      @tag = Tag.find(params[:id])
    end

    def create
      @tag = Tag.new(organizer_params)
      if @tag.save
        flash[:success] = 'Тег успешно создан'
        redirect_to [:admin, @tag]
      else
        flash[:danger] = 'Во время создания произошла ошибка'
        render 'new'
      end
    end

    def update
      @tag = Tag.find(params[:id])
      if @tag.update(organizer_params)
        flash[:success] = 'Тег успешно изменён'
        redirect_to [:admin, @tag]
      else
        flash[:danger] = 'Во время редактирования произошла ошибка'
        render 'edit'
      end
    end

    def destroy
      @tag = Tag.find(params[:id])
      flash[:success] = if @tag.destroy
                          'Тег успешно удалён'
                        else
                          'Во время удаления произошла ошибка'
                        end
      redirect_to admin_tags_path
    end

    private

    def organizer_params
      params.require(:tag).permit(:name, :active)
    end
  end
end
