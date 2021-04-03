# frozen_string_literal: true

class ChangeFieldsRequirementsInEvents < ActiveRecord::Migration[6.0]
  def up
    change_column_null(:events, :city, false)
    change_column_null(:events, :title, false)
    change_column_null(:events, :location, false)
    change_column_null(:events, :link, false)
    change_column_null(:events, :event_date, false)
  end

  def down
    change_column_null(:events, :city, true)
    change_column_null(:events, :title, true)
    change_column_null(:events, :location, true)
    change_column_null(:events, :link, true)
    change_column_null(:events, :event_date, true)
  end
end
