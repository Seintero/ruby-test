# frozen_string_literal: true

class ChangeFieldsRequirementsOrganizers < ActiveRecord::Migration[6.0]
  def up
    change_column_null(:organizers, :name, false)
    add_index :organizers, :name, unique: true
  end

  def down
    change_column_null(:organizers, :name, true)
    remove_index :organizers, :name
  end
end
