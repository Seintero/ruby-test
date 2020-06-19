class SubscribersController < ApplicationController

  def create
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {}
      format.json {
        begin
          @subscriber = Subscriber.new(subscriber_params)
          if @subscriber.save
            data = {message: "Вы успешно подписаны", status: "success"}
          else
            data = {message: @subscriber.errors.full_messages, status: "error"}
          end
        rescue
          data = {message: "Произошла ошибка", status: "error"}
        end

        render json: data
      }
    end
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
