# frozen_string_literal: true

class AddOrganizerToEvents < ActiveRecord::Migration[6.0]
  def change
    change_table :events do |t|
      t.belongs_to :organizer
    end
  end
end
