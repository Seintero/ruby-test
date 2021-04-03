# frozen_string_literal: true

class SubscribersController < ApplicationController
  def create
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
      format.json do
        begin
          @subscriber = Subscriber.new(subscriber_params)
          if @subscriber.save
            SubscriptionMailer.with(email: @subscriber.email).welcome_email.deliver_now
            data = { message: 'Вы успешно подписаны', status: 'success' }
          else
            data = { message: @subscriber.errors.full_messages, status: 'error' }
          end
        rescue StandardError => e
          data = { message: "Произошла ошибка #{e.message}", status: 'error' }
        end

        render json: data
      end
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
