# frozen_string_literal: true

class AddTags < ActiveRecord::Migration[6.0]
  create_table :tags do |t|
    t.string :name
    t.boolean :active, default: true
    t.timestamps
  end

  create_table :events_tags, id: false do |t|
    t.belongs_to :event
    t.belongs_to :tag
  end
end
