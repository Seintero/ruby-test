# frozen_string_literal: true

module Admin
  class SubscribersController < AdminController
    def index
      @subscribers = Subscriber.paginate(page: params[:page], per_page: 9)
    end

    def edit
      @subscriber = Subscriber.find(params[:id])
    end

    def update
      @subscriber = Subscriber.find(params[:id])
      if @subscriber.update(subscriber_params)
        flash[:success] = 'Подписчик успешно изменён'
        redirect_to admin_subscribers_path
      else
        flash[:danger] = 'Во время редактирования произошла ошибка'
        render 'edit'
      end
    end

    def destroy
      @subscriber = Subscriber.find(params[:id])
      flash[:success] = if @subscriber.destroy
                          'Подписчик успешно удалён'
                        else
                          'Во время удаления произошла ошибка'
                        end
      redirect_to admin_subscribers_path
    end

    private

    def subscriber_params
      params.require(:subscriber).permit(:email, :active)
    end
  end
end
