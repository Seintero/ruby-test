module Events
  class Filter < ActiveInteraction::Base
    hash :params, strip: false

    def execute
      puts params[:city]
      puts inputs
      Event.all
           .past_or_future(params[:filter_date])
           .city(params[:city])
           .date_start(params[:date_start])
           .organizer(params[:organizer])
           .order('event_date DESC')
           .paginate(page: params[:page], per_page: 8)
    end
  end
end
