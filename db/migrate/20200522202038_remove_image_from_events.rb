# frozen_string_literal: true

class RemoveImageFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :image, :string
  end
end
