class AddDescriptionToOrganizers < ActiveRecord::Migration[6.0]
  def change
    add_column :organizers, :description, :string, column_options: { null: true }
  end
end
