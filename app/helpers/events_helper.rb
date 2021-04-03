# frozen_string_literal: true

module EventsHelper
  def formatted_time(date)
    date.strftime('%k:%M')
  end

  def formatted_date(date)
    date.strftime('%d.%m.%Y')
  end
end
