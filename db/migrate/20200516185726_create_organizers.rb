# frozen_string_literal: true

class CreateOrganizers < ActiveRecord::Migration[6.0]
  def change
    create_table :organizers do |t|
      t.string :name
      t.timestamps
    end
  end
end
